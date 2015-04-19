#!/usr/bin/env python
"""
ec2_tags.py - exports all EC2 tags in an 'ec2_tags' grain and splits 'Role' tag
              into a list on 'ec2_roles' grain.

To use it:

  1. Place ec2_tags.py in <salt_root>/_grains/
  2. Make sure boto version >= 2.8.0
  3. There are three ways of supplying AWS credentials used to fetch instance tags:

    i. Define them in AWS_CREDENTIALS below
    ii. Define AWS_ACCESS_KEY and AWS_SECRET_KEY environment variables
    iii. Provide them in the minion config like this:

        ec2_tags:
          aws:
            access_key: ABC123
            secret_key: abc123
    iv. Use IAM roles

  4. Test it

    $ salt '*' saltutil.sync_grains
    $ salt '*' grains.get ec2_tags
    $ salt '*' grains.get ec2_roles

Author: Emil Stenqvist <emsten@gmail.com>
Licensed under Apache License (https://raw.github.com/saltstack/salt/develop/LICENSE)

(Inspired by https://github.com/dginther/ec2-tags-salt-grain)
"""

import os
import logging
from distutils.version import StrictVersion

import boto.ec2
import boto.utils
import salt.log
import salt.utils.iam as iam

log = logging.getLogger(__name__)

AWS_CREDENTIALS = {
    'access_key': None,
    'secret_key': None,
    'security_token': None,
}


def _get_instance_info():
    identity = boto.utils.get_instance_identity()['document']
    return identity['instanceId'], identity['region']


def _on_ec2():
    m = boto.utils.get_instance_metadata(timeout=0.1, num_retries=1)
    return bool(m)


def _get_credentials():
    creds = AWS_CREDENTIALS.copy()

    # iam
    try:
        aws = iam.get_iam_metadata()
        if aws.get('access_key') and aws.get('secret_key') and aws.get('security_token'):
            creds.update(dict(access_key=aws.get('access_key'), secret_key=aws.get('secret_key'), security_token=aws.get('security_token')))
    except Exception:
        pass

    # Minion config
    if '__opts__' in globals():
        conf = __opts__.get('ec2_tags', {})
        aws = conf.get('aws', {})
        if aws.get('access_key') and aws.get('secret_key'):
            creds.update(aws)

    # 3. Get from environment
    access_key = os.environ.get('AWS_ACCESS_KEY') or os.environ.get('AWS_ACCESS_KEY_ID')
    secret_key = os.environ.get('AWS_SECRET_KEY') or os.environ.get('AWS_SECRET_ACCESS_KEY')
    if access_key and secret_key:
        creds.update(dict(access_key=access_key, secret_key=secret_key))

    return creds


def ec2_tags():
    boto_version = StrictVersion(boto.__version__)
    required_boto_version = StrictVersion('2.8.0')
    if boto_version < required_boto_version:
        log.error("Installed boto version %s < %s, can't find ec2_tags",
                  boto_version, required_boto_version)
        return None

    if not _on_ec2():
        log.info("Not an EC2 instance, skipping")
        return None

    instance_id, region = _get_instance_info()
    credentials = _get_credentials()

    # Connect to EC2 and parse the Roles tags for this instance
    if not (credentials['access_key'] and credentials['secret_key']):
        log.error("No AWS credentials found, see documentation for how to provide them.")
        return None

    try:
        conn = boto.ec2.connect_to_region(
            region,
            aws_access_key_id=credentials['access_key'],
            aws_secret_access_key=credentials['secret_key'],
            security_token=credentials['security_token'],
        )
    except Exception, e:
        log.error("Could not get AWS connection: %s", e)
        return None

    ec2_tags = {}
    try:
        tags = conn.get_all_tags(filters={'resource-type': 'instance',
                                          'resource-id': instance_id})
        for tag in tags:
            ec2_tags[tag.name] = tag.value
    except Exception, e:
        log.error("Couldn't retrieve instance tags: %s", e)
        return None

    ret = dict(ec2_tags=ec2_tags)

    # Provide ec2_tags_roles functionality
    if 'Roles' in ec2_tags:
        ret['roles'] = ec2_tags['Roles'].split(',')

    return ret


if __name__ == '__main__':
    print ec2_tags()

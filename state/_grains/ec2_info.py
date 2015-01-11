#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Get some grains information that is only available in Amazon AWS

Author: Erik Günther, J C Lawrence <claw@kanga.nu>, Mark McGuire

"""
import logging
import httplib
import socket
import json

# Set up logging
LOG = logging.getLogger(__name__)


def _call_aws(url):
    """
    Call AWS via httplib. Require correct path.
    Host: 169.254.169.254

    """
    conn = httplib.HTTPConnection("169.254.169.254", 80, timeout=1)
    conn.request('GET', url)
    response = conn.getresponse()
    if response.status == 200:
        return response.read()


def _get_ec2_hostinfo(path=""):
    """
    Recursive function that walks the EC2 metadata available to each minion.
    :param path: URI fragment to append to /latest/meta-data/
    :param data: Dictionary containing the results from walking the AWS meta-data

    All EC2 variables are prefixed with "ec2_" so they are grouped as grains and to
    avoid collisions with other grain names.
    """
    resp = _call_aws("/latest/meta-data/%s" % path)
    try:
        data = json.loads(resp)
        if isinstance(data, dict):
            return data
    except ValueError:
        pass

    d = {}
    for line in resp.split("\n"):
        if line[-1] != "/":
            call_response = _call_aws("/latest/meta-data/%s" % (path + line))
            if call_response is not None:
                d[line] = call_response
            else:
                return json.loads(line)
        else:
            d[line] = _get_ec2_hostinfo(path + line)
    return d


def _camel_to_snake_case(s):
    return "".join((("_" + x.lower()) if x.isupper() else x) for x in s)


def _get_ec2_additional():
    """
    Recursive call in _get_ec2_hostinfo() does not retrieve some of
    the hosts information like region, availability zone or
    architecture.

    """
    data = json.loads(_call_aws("/latest/dynamic/instance-identity/document"))
    return {_camel_to_snake_case(k): v for k, v in data.items()}


def ec2_info():
    """
    Collect some extra host information
    """
    try:
        # First check that the AWS magic URL works. If it does
        # we are running in AWS and will try to get more data.
        _call_aws('/')
    except (socket.timeout, socket.error, IOError):
        return {}

    try:
        grains = _get_ec2_additional()
        grains.update(_get_ec2_hostinfo())
        return {'ec2' : grains}
    except socket.timeout, serr:
        LOG.info("Could not read EC2 data (timeout): %s" % (serr))
        return {}

    except socket.error, serr:
        LOG.info("Could not read EC2 data (error): %s" % (serr))
        return {}

    except IOError, serr:
        LOG.info("Could not read EC2 data (IOError): %s" % (serr))
        return {}

if __name__ == "__main__":
    print ec2_info()

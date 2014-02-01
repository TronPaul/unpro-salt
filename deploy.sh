#!/bin/bash

if [ -e /srv/salt ]
then
  rm -rf /srv/salt
fi
cp -r state /srv/salt

if [ -e /srv/pillar ]
then
  rm -rf /srv/pillar
fi
cp -r pillar /srv/pillar

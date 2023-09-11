#! /bin/bash

# NAME: diskuse

# AUTHOR: Thomas Sandholm

# DATE: Thu Aug 21 18:41:14 EDT 2008

# SUMMARY: Network service to show the diskuse of local ext3 filesystems.

# VERSION: 1.0

# DESCRIPTION:  This program will be called by inetd as a network service.  It

#               runs on port 5192 using the TCP protocol.  It will show the disk

#               usage for local ext3 filesystems.  It uses the df command to get

#               the disk usage data and filters out the header line and replaces

#               multiple whitespace with a colon (:).

# MAIN

df -l -t ext3 | sed -e 1d -e 's/[ ][ ]*/:/g'

exit 0
#!/bin/sh -e
#
# Copyright (C) Internet Systems Consortium, Inc. ("ISC")
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# See the COPYRIGHT file distributed with this work for additional
# information regarding copyright ownership.

SYSTEMTESTTOP=../..
. $SYSTEMTESTTOP/conf.sh

( cd ../ns2 && $SHELL -e sign.sh )

cp ../ns2/dsset-* .

zone=.
infile=root.db.in
zonefile=root.db

keyname1=`$KEYGEN -a RSASHA256 -f KSK $zone 2> /dev/null`
keyname2=`$KEYGEN -a RSASHA256 $zone 2> /dev/null`

cat $infile $keyname1.key $keyname2.key > $zonefile

$SIGNER -P -g -o $zone $zonefile > /dev/null

keyfile_to_trusted_keys $keyname1 > trusted.conf
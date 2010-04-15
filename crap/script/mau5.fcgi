#!/bin/sh

ulimit -m 1073741824
ulimit -v 1073741824

cd /var/www/xilr8d/ReqMgmt
exec perl -I/var/www/xilr8d/perl5/lib/perl5 script/mau5_fastcgi.pl $$


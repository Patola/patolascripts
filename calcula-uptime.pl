#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  calcula-uptime.pl
#
#        USAGE:  ./calcula-uptime.pl [uptime string]
#
#  DESCRIPTION:  uptime calculation
#
#      OPTIONS:  if there's an argument, considers it the uptime string. If there
#                isn't, return the uptime of the current machine.
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Cláudio Sampaio <patola@gmail.com>
#      COMPANY:  IBM
#      VERSION:  0.1
#      CREATED:  20-05-2012 00:45:36
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


##############################################
## toDate(para1)
## convert from seconds to dd-hh-mm-ss
sub toDate($)
{
  my ($DAYS, $HOURS, $MINUTES, $SECONDS, $REST);
  $DAYS=int ($_[0]/86400);  # 3600sec*24hrs, get # days
  $REST=$_[0]%86400;    # get the remainder
  $HOURS=int ($REST/3600);  # get hrs
  $REST=$REST%3600;    # get the remainder
  $MINUTES=int ($REST/60);  # get mins
  $SECONDS=$REST%60;    #
  return "$DAYS days, $HOURS hours, $MINUTES minutes, $SECONDS seconds.";
}

my $uptimestring=($#ARGV==0)?`cat /proc/uptime`:$ARGV[0];
if ($#ARGV < 0) { # 1 argument, and only one
  $uptimestring=`cat /proc/uptime`;
} else {
  $uptimestring=$ARGV[0];
}

$uptimestring=~s/\s.*//; # take off everything after a space
$uptimestring=int($uptimestring);

printf "%s\n", toDate($uptimestring);


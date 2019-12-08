#!/bin/bash

# TODO getopts
PULL_ALL=$1

# Fuzzy match packages installed on device
MATCHES=$(adb shell pm list packages | fzf)
if [ -z $MATCHES ]
then
  exit 1
fi

# adb outputs as package:com.foo.bar.baz
PACKAGE=$(echo $MATCHES | cut -d : -f 2)
echo $PACKAGE

# Apps may contain multiple apks for different locales/configs
# https://developer.android.com/studio/build/configure-apk-splits
# Assume only base.apk is important
PATH_OPTIONS=$(adb shell pm path $PACKAGE)
PATH_COUNT=$(echo "$PATH_OPTIONS" | wc -l)
if [ $PATH_COUNT -eq 1 ]
then
  PATHS=($PATH_OPTIONS)
#else
#  if [ $(echo "$PATH_OPTIONS" | wc -l) -gt 1 ] && [ -z $PULL_ALL ]
#  then
#    PATHS=($(echo "$PATH_OPTIONS" | fzf))
#  fi
else
  PATHS=($(echo "$PATH_OPTIONS" | grep -iF base))
fi
echo ${PATHS[@]}

for P in "${PATHS[@]}"; do
  apk_path=$(echo $P | cut -d : -f 2)
  adb pull $apk_path
done

#!/bin/bash
# set this to run at the day and time you want to wake up
# loop all of this (with a 1 minute pause at the end) to be like a "snooze button" if the switch is not turned off
# try all of this, and catch error by playing prerecorded "Good morning, it appears that we don't have Internet access, but you need to get up anyway"
# if GPIO pin (switch) is on then do all of this, else skip (and stay silent)
dayName=`date +%A`
month=`date +%B`
dayNumber=`date +%d`
# do some things to get the weather
weather=`/usr/bin/wget -q -O- "http://api.openweathermap.org/data/2.5/forecast/daily?q=Edmonton,ca&units=metric&cnt=1&mode=xml"`
temperatures=`echo $weather | grep temperature`
highTemp=`echo $temperatures | awk -F'"' '{print $6}`
symbol=`echo $weather | grep symbol`
conditions=`echo $symbol | awk -F'"' '{print $4}`
# build what we'll have it say
# Good morning. Today is $dayName, $month $dayNumber+st/nd/rd/th. The forecast calls for $conditions and $highTemp degrees.
speakThis=
# call the mpg123 program to speak the text (using a Google Translate URL)
mpg123 -q "http://translate.google.com/translate_tts?tl=en&q=Today+is+Monday%2C+January+5th"

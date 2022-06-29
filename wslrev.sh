#!/bin/bash

user=$(whoami)

cd /Users/armsna/Desktop/logrev

echo "First event- Windows 1102: The audit log was cleared @"
tail -6 SecurityLog-rev2.xml | grep -o 'SystemTime.*'

echo "Last event- Windows 4634: An account was logged off @"
head -10 SecurityLog-rev2.xml | grep -o 'SystemTime.*'

echo "Total number of events:"
grep -n "<EventID>" SecurityLog-rev2.xml | wc -l

echo "Total number of login events (4624: An account was successfully logged on):"
grep -n "<EventID>4624" SecurityLog-rev2.xml | wc -l

echo "Log on frequency for each user:"
grep -o "<EventID>4624" SecurityLog-rev2.xml 

echo "Total number of different users:"
grep -o "<EventData><Data Name='TargetUserSid'>S.*" SecurityLog-rev2.xml | awk 'length>90'| awk '!seen[$0]++' | wc -l

grep -o "<EventData><Data Name='TargetUserSid'>S.*" SecurityLog-rev2.xml | awk 'length>90'> temp.txt #| sort freq.txt | uniq -c | sort -n > freq.txt
grep -o "<EventData><Data Name='TargetUserSid'>S.*" SecurityLog-rev2.xml > temp2.txt #includes 

awk '{!seen[$0]++}END{for (i in seen) print seen[i], i}' temp2.txt | sort -n > freq2.txt

awk '{!seen[$0]++}END{for (i in seen) print seen[i], i}' temp.txt | sort -n > freq.txt
#OR
#sort temp.txt | uniq -c | sort -n > freq.txt

echo "Total number of login events (4625: An account failed to log on):"
grep -n "<EventID>4625" SecurityLog-rev2.xml | wc -l
#!/usr/bin/python
import sys
import datetime
for line in sys.stdin:
    line=line.strip()
    userid, movieid, rating, unixtime = line.split('\t')
    timetransform=datetime.datetime.strptime(unixtime,"%Y-%m-%d %H:%M:%S")
    weekday=timetransform.weekday()+1
    print ('\t'.join([userid, movieid , rating , str(weekday)]))
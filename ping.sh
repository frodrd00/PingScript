#!/bin/bash

trap "exit" INT

#PING unileon.es (193.146.99.17) 56(84) bytes of data.
PING=`ping -c 1 unileon.es | grep "PING" | cut -d " " -f 3 | tr -d "(" | tr -d ")"`
echo "IP of unileon.es is: $PING" 

HOST="whois.ripe.net $PING"

#inetnum:        193.146.96.0 - 193.146.111.255
IP1=`whois -h $HOST | grep "inetnum" | cut -d " " -f 9`
IP2=`whois -h $HOST | grep "inetnum" | cut -d " " -f 11`

echo "IP RANGE of unileon.es is: $IP1 - $IP2 " 

#A=96 B=111 C=0 D=25
A=`echo $IP1 | cut -d "." -f 3`
B=`echo $IP2 | cut -d "." -f 3`
C=`echo $IP1 | cut -d "." -f 4`
D=`echo $IP2 | cut -d "." -f 4`

COUNTDOWN=0
COUNTUP=0

for i in $( eval echo {$A..$B} )
 do for j in $( eval echo {$C..$D} )
  do
    ping 193.146.$i.$j -c 1 -w 5 >/dev/null
    if [ "$?" = 0 ]
     then 
	  echo "193.146.$i.$j is up!"
	  COUNTUP=$((COUNTUP+1))
	else
	  echo "193.146.$i.$j is down!"
	  COUNTDOWN=$((COUNTDOWN+1))
	fi
  done 
done

echo "IPs UP: $COUNTUP"
echo "IPs DOWN: $COUNTDOWN"


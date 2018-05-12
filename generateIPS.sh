#!/bin/bash

#PING unileon.es (193.146.99.17) 56(84) bytes of dat
PING=`ping -c 1 unileon.es | grep "PING" | cut -d " " -f 3 | tr -d "(" | tr -d ")"`

HOST="whois.ripe.net $PING"

#inetnum:        193.146.96.0 - 193.146.111.255
A=`whois -h $HOST | grep "inetnum" | cut -d " " -f 9 | cut -d "." -f 3`
B=`whois -h $HOST  | grep "inetnum" | cut -d " " -f 9 | cut -d "." -f 4`
C=`whois -h $HOST  | grep "inetnum" | cut -d " " -f 11 | cut -d "." -f 3`
D=`whois -h $HOST | grep "inetnum" | cut -d " " -f 11 | cut -d "." -f 4`

for i in $( eval echo {$A..$C} )
 do for j in $( eval echo {$B..$D} )
  do
    echo "193.146.$i.$j"
  done 
done

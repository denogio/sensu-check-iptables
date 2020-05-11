#!/bin/bash

WHICH='/usr/bin/which'
IPTABLES=$($WHICH iptables)
GREP=$($WHICH grep)
AWK=$($WHICH awk)
EXPR=$($WHICH expr)
WC=$($WHICH wc
)
STAT=0
OUTPUT=''
CHAINS=`$IPTABLES -nvL | $GREP 'Chain' | $AWK '{ print $2 }'`

for CHAIN in $CHAINS ; do
        if [ "$CHAIN" != 'FORWARD' ] && [ "$CHAIN" != 'OUTPUT' ] && [ `$EXPR substr $CHAIN 1 4` != "LOG_" ] ; then
                CNT=`expr $($IPTABLES -S $CHAIN | $WC -l) '-' 1`
                if [ $CNT -eq 0 ] ; then
                        OUTPUT="${OUTPUT}ERROR $CHAIN $CNT rules!\n"
                        STAT=2
                else
                        OUTPUT="${OUTPUT}OK $CHAIN $CNT rules\n"
                fi
        fi
done

printf "$OUTPUT"

exit $STAT



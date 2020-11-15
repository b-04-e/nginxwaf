FROM alpine:latest
Label manteiner="Ernesto Rode aka b-04 <ernesto@erconsultor.com>"
# packages needed to compile / paquetes necesarios para compilar

RUN apk update && apk upgrade
RUN apk add --update wget \
	tar \
	autoconf \
	automake \ 
	build-base \ 
	git \ 
	openssl-dev \
	curl-dev \
 	geoip-dev \
 	lmdb-dev \
 	pcre-dev \
 	libtool \
 	libxml2-dev \
 	libressl-dev \ 
	yajl-dev \
 	pkgconf  \
	zlib-dev \
	linux-headers 
	
# I download and compile modsecurity from github official repository / Bajo y compilo modsecurity de github repositorio oficial

RUN cd /tmp && git clone https://github.com/SpiderLabs/ModSecurity 
RUN cd /tmp/ModSecurity && git submodule init && git submodule update
RUN cd /tmp/ModSecurity && ./build.sh && \
	./configure && \
	make && \
	make install

# I download and compile nginx from the official website / I download and compile nginx from the official website

RUN cd /tmp && git clone --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git \
    && wget http://nginx.org/download/nginx-1.19.4.tar.gz \
    && tar zxvf nginx-1.19.4.tar.gz

RUN cd /tmp/nginx-1.19.4/ && ./configure  --user=root --group=root --with-debug --with-ipv6 --with-http_ssl_module  --with-compat --add-module=/tmp/ModSecurity-nginx --without-http_access_module --without-http_auth_basic_module --without-http_autoindex_module --without-http_empty_gif_module --without-http_fastcgi_module --without-http_referer_module --without-http_memcached_module --without-http_scgi_module --without-http_split_clients_module --without-http_ssi_module --without-http_uwsgi_module \
    && make \
    && make install 

# i download the updated owasp rules / descargo las reglas actualizadas de owasp

RUN git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/src/owasp-modsecurity-crs
RUN cp -R /usr/src/owasp-modsecurity-crs/rules/ /usr/local/nginx/conf/ 
RUN mv /usr/local/nginx/conf/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example  /usr/local/nginx/conf/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf 
RUN mv /usr/local/nginx/conf/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example  /usr/local/nginx/conf/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf 

# fail2ban instalacion

RUN apk add fail2ban
RUN rm /etc/fail2ban/jail.d/alpine-ssh.conf

# start nginx and fail2ban. expose 80 port for nginx / inicio nginx y fail2ban. expongo el puerto 80 para nginx

CMD ./usr/local/nginx/sbin/nginx -g 'daemon off;'
CMD [ "fail2ban-server", "-f", "-x", "-v", "start" ]


EXPOSE 80

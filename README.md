English / Spanish

Hello! This is an alpine-based nginx image. It has ModSecurity activated that works like WAF.
It also has fail2ban to prevent DDoS attacks and more.
By default, fail2ban and WAF are enabled and logged in.

Next, I explain how to quickly install this solution:

 - Requirements: Docker, Docker-Compose
- Clone the repository to download:
   $ git clone https://github.com/b-04-e/nginxwaf
- Enter the nginxwaf / config directory, edit the nginx.conf file and add the blocks of your servers, if you don't, nginx raises a default index.html page.
- Run:
 $ docker-compose up -d
- The image will be created and started automatically listening on port 80, you can access to test by placing http: //ip.docker

The structure of persistent volumes is as follows:

Config folder: contains the nginx and modsecurity configuration files.
Fail2ban folder: contains the fail2ban service configuration files
Logs folder: contains the logs nginx (access.log and error.log), ModSecurity (modsec_audit.log) and fail2ban (fail2ban.log)

You can quickly test the operation of this reverse proxy / web server by doing:

$ docker-compose up -d
$ curl "http: //localhost/index.html? t = <script> window.alert \ (" hello "\) </script>"

And you get as a result, the lock:

--- 5s3V5xAh --- F--
HTTP / 1.1 403
Server: nginx / 1.19.4

you can read it in the log:

$ cat logs / modsec_audit.log

--- 5s3V5xAh --- H--
ModSecurity: Warning. detected XSS using libinjection. [file "/usr/local/nginx/conf/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf"] [line "37"] [id "941100"] [rev ""] [msg "XSS Attack Detected via libinjection "] [data" Matched Data: XSS data found within ARGS: t: <script> window.alert (hello) </script> "] [severity" 2 "] [see" OWASP_CRS / 3.2.0 "] [ maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-xss"] [tag "paranoia-level / 1 "] [tag" OWASP_CRS "] [tag" OWASP_CRS / WEB_ATTACK / XSS "] [tag" WASCTC / WASC-8 "] [tag" WASCTC / WASC-22 "] [tag" OWASP_TOP_10 / A3 "] [tag" OWASP_AppSensor / IE1 "] [tag" CAPEC-242 "] [hostname" 172.19.0.2 "] [uri" /index.html "] [unique_id" 1605319184 "] [ref" v18,37t: utf8toUnicode, t: urlDecodeUni, t : htmlEntityDecode, t: jsDecode, t: cssDecode, t: removeNulls "]
ModSecurity: Warning. Matched "Operator` Rx 'with parameter `(? I) <script [^>] *> [\ s \ S] *?' against variable `ARGS: t '(Value:` <script> window.alert \ (hello \) </script>') [file "/ usr / local / nginx / conf / rules / REQUEST-941-APPLICATION-ATTACK- XSS.conf "] [line" 68 "] [id" 941110 "] [rev" "] [msg" XSS Filter - Category 1: Script Tag Vector "] [data" Matched Data: <script> found within ARGS: t : <script> window.alert (hello) </script> "] [severity" 2 "] [see" OWASP_CRS / 3.2.0 "] [maturity" 0 "] [accuracy" 0 "] [tag" application-multi "] [" language-multi "tag] [" platform-multi "tag] [" attack-xss "tag] [" paranoia-level / 1 "tag] [" OWASP_CRS "tag] [" OWASP_CRS / WEB_ATTACK / XSS tag "] [tag" WASCTC / WASC-8 "] [tag" WASCTC / WASC-22 "] [tag" OWASP_TOP_10 / A3 "] [tag" OWASP_AppSensor / IE1 "] [tag" CAPEC-242 "] [hostname" 172.19 .0.2 "] [uri" /index.html "] [unique_id" 1605319184 "] [ref" o0,8v18,37t: utf8toUnicode, t: urlDecodeUni, t: htmlEntityDecode, t: jsDecode, t: cssDecode, t: removeNulls " ]

-----------------------------------------------------------------------


Hola! Esta es una imagen de nginx basada en alpine. Posee ModSecurity activado que funciona como WAF.
Tambien tiene fail2ban para prevenir ataques DDoS y demas.
Por default, fail2ban y el WAF vienen activados y logueando.

A continuacion, explico como instalar rapidamente esta solucion:

 - Requerimientos: Docker, Docker-Compose
- Clonar el repositorio para descargar: 
   $ git clone https://github.com/b-04-e/nginxwaf
- Ingrese al directorio nginxwaf/config, edite el archivo nginx.conf y agregue los bloques de sus servidores, si no lo hace, nginx levanta con una pagina default index.html.
- Ejecute: 
 $ docker-compose up -d
- La imagen se creara y se iniciara automaticamente escuchando en el puerto 80, puedes acceder para probar colocando http://ip.docker

La estructura de volumenes persistentes esta de la siguiente forma:

Carpeta config: contiene los archivos de configuracion de nginx y modsecurity.
Carpeta fail2ban: contiene los archivos de configuracion del servicio fail2ban
Carpeta logs: contiene los logs nginx (access.log y error.log), ModSecurity (modsec_audit.log) y fail2ban (fail2ban.log)

Puede probar rapidamente el funcionamiento de este proxy reverso / web server, haciendo: 

$ docker-compose up -d
$ curl "http://localhost/index.html?t=<script>window.alert\("hola"\)</script>"

Y obtienes como resultado, el bloqueo:

---5s3V5xAh---F--
HTTP/1.1 403
Server: nginx/1.19.4

lo puedes leer en el log:

$ cat logs/modsec_audit.log

---5s3V5xAh---H--
ModSecurity: Warning. detected XSS using libinjection. [file "/usr/local/nginx/conf/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf"] [line "37"] [id "941100"] [rev ""] [msg "XSS Attack Detected via libinjection"] [data "Matched Data: XSS data found within ARGS:t: <script>window.alert(hola)</script>"] [severity "2"] [ver "OWASP_CRS/3.2.0"] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-xss"] [tag "paranoia-level/1"] [tag "OWASP_CRS"] [tag "OWASP_CRS/WEB_ATTACK/XSS"] [tag "WASCTC/WASC-8"] [tag "WASCTC/WASC-22"] [tag "OWASP_TOP_10/A3"] [tag "OWASP_AppSensor/IE1"] [tag "CAPEC-242"] [hostname "172.19.0.2"] [uri "/index.html"] [unique_id "1605319184"] [ref "v18,37t:utf8toUnicode,t:urlDecodeUni,t:htmlEntityDecode,t:jsDecode,t:cssDecode,t:removeNulls"]
ModSecurity: Warning. Matched "Operator `Rx' with parameter `(?i)<script[^>]*>[\s\S]*?' against variable `ARGS:t' (Value: `<script>window.alert\(hola\)</script>' ) [file "/usr/local/nginx/conf/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf"] [line "68"] [id "941110"] [rev ""] [msg "XSS Filter - Category 1: Script Tag Vector"] [data "Matched Data: <script> found within ARGS:t: <script>window.alert(hola)</script>"] [severity "2"] [ver "OWASP_CRS/3.2.0"] [maturity "0"] [accuracy "0"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "attack-xss"] [tag "paranoia-level/1"] [tag "OWASP_CRS"] [tag "OWASP_CRS/WEB_ATTACK/XSS"] [tag "WASCTC/WASC-8"] [tag "WASCTC/WASC-22"] [tag "OWASP_TOP_10/A3"] [tag "OWASP_AppSensor/IE1"] [tag "CAPEC-242"] [hostname "172.19.0.2"] [uri "/index.html"] [unique_id "1605319184"] [ref "o0,8v18,37t:utf8toUnicode,t:urlDecodeUni,t:htmlEntityDecode,t:jsDecode,t:cssDecode,t:removeNulls"]

#!/bin/bash
#定义变量
shell_version="1.1.5.7"
jemalloc_ver="5.2.1"
openssl_ver="1.1.1l"
nginx_ver="1.20.1"
nginx_service="/etc/systemd/system/nginx.service"

cd /root || exit
#更新系统
apt-get update
apt-get upgrade -y

#安装依赖
apt-get install build-essential libpcre3 libpcre3-dev zlib1g-dev libssl-dev wget curl tar unzip cmake git -y

#安装jemalloc
jemalloc_install() {
cd /etc || exit
wget -nc --no-check-certificate https://github.com/jemalloc/jemalloc/releases/download/${jemalloc_ver}/jemalloc-${jemalloc_ver}.tar.bz2

tar -xvf jemalloc-${jemalloc_ver}.tar.bz2

cd jemalloc-${jemalloc_ver}

apt-get install autogen autoconf

./autogen.sh

make
make install
ldconfig 

cd /etc 
rm -rf jemalloc-${jemalloc_ver} jemalloc-${jemalloc_ver}.tar.bz2

}

#下载openssl
openssl_download() {

cd /etc

wget -c https://www.openssl.org/source/openssl-${openssl_ver}.tar.gz && tar zxf openssl-${openssl_ver}.tar.gz && rm openssl-${openssl_ver}.tar.gz

 }

 #安装nginx
nginx_install() {
cd /etc/
wget http://nginx.org/download/nginx-${nginx_ver}.tar.gz&&tar xf nginx-${nginx_ver}.tar.gz

cd nginx-${nginx_ver}

./configure \
  --prefix=/etc/nginx \
  --with-http_ssl_module \
  --with-http_gzip_static_module \
  --with-http_stub_status_module \
  --with-pcre \
  --with-http_realip_module \
  --with-http_flv_module \
  --with-http_mp4_module \
  --with-http_secure_link_module \
  --with-http_v2_module \
  --with-cc-opt=-O3 \
  --with-ld-opt=-ljemalloc \
  --with-openssl=../openssl-${openssl_ver} \
  --with-stream \
  --with-stream_ssl_module \
  --with-stream=dynamic \
  --with-stream_ssl_preread_module

make
make install

 }

 #添加nginx-service系统文件
 nginx_service() {
    cat >$nginx_service <<EOF
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/etc/nginx/logs/nginx.pid
ExecStartPre=/etc/nginx/sbin/nginx -t
ExecStart=/etc/nginx/sbin/nginx -c /etc/nginx/conf/nginx.conf
ExecReload=/etc/nginx/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT \$MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl start nginx 
systemctl enable nginx

 }

 /etc/nginx/sbin/nginx -V

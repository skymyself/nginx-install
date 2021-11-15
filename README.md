# nginx-install
nginx编译安装

**检查最新版本

[查看jemalloc最新版本](https://github.com/jemalloc/jemalloc/releases)

[查看openssl最新版本](https://github.com/openssl/openssl/tags)

[查看nginx最新版本](http://nginx.org/en/download.html)


**执行脚本前，如有需要安装最新版
请改如下变量的版本号即可

脚本当前安装的版本为：
```
jemalloc-ver="5.2.1"
openssl-ver="1.1.1l"
nginx-ver="1.20.1"
```

**一键更新nginx版本
```
wget -N --no-check-certificate "https://raw.githubusercontent.com/skymyself/nginx-install/upgrade/upgrade_nginx.sh" && chmod +x upgrade_nginx.sh && bash upgrade_nginx.sh
```

出现如下类似错误：
```
$'\r': command not found
```
解决方法：
```
sed -i 's/\r//' nginx.sh
bash nginx.sh
```
或
```
apt-get install dos2unix -y
dos2unix nginx.sh
bash nginx.sh
```


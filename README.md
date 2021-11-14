# nginx-install
nginx编译安装

**检查最新版本

[查看jemalloc最新版本](https://github.com/jemalloc/jemalloc)

[查看openssl最新版本](https://github.com/openssl/openssl/tags)

[查看nginx最新版本](http://nginx.org/en/download.html)


执行脚本前，如有需要安装最新版
请改如下变量的版本号即可

脚本当前安装的版本为：
```
jemalloc-ver="5.2.1"
openssl-ver="1.1.1l"
nginx-ver="1.20.1"
```

**执行
```
wget -N --no-check-certificate "https://raw.githubusercontent.com/skymyself/nginx-install/main/nginx.sh" && chmod +x nginx.sh && ./nginx.sh

```

**可能需要安装一下curl
```
 apt-get install curl -y
```

#coreseek_docker
	version=3.2.14

#Thanks from 
	https://github.com/sunfjun/Dockfile-Coreseek/

########################################################


 mkdir -p /data/docker/coreseek/{conf,log,data}
 
 rz -y test_qq.conf
 mv test_qq.conf /data/docker/coreseek/conf/sphinx.conf
 
 mysql < test_qq.sql
 
 docker run -d -p 9312:9312 \
 -v /data/docker/coreseek/conf:/usr/local/etc/sphinx \
 -v /data/docker/coreseek/log:/var/sphinx/log \
 -v /data/docker/coreseek/data:/var/sphinx/data \
 --name sphinx liwl1iwl/coreseek:3.2.14
 
########################################################


docker exec  sphinx search 百度
docker exec  sphinx search 谷歌




# 获取当前目录路径
cd `dirname $0`
path=$PWD

#进入相应的目录
cd "$path/$1"
docker-compose up -d

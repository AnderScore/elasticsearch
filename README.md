docker-machine.exe ls
docker volume create --name esdata

docker build -t my-es-image .
docker run --rm -p 9200:9200 -v esdata:/elasticsearch/data my-es-image
docker run --rm -p 9200:9200 -v /c/Users/<user>/docker-data:/elasticsearch/data my-es-image

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

Sense:
https://chrome.google.com/webstore/detail/sense-beta/lhjgkmllcaadmopgmanpapmpjgmfcfig

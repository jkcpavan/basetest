# basetest
docker build -t local/chrm0.0.1

docker run -p 5900:5900 -e VNC_SERVER_PASSWORD=password --user apps --privileged local/chrm0.0.1



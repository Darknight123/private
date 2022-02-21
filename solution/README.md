
1. install docker and docker-compose,start docker service,make it enabled post restart as well:
#yum install docker
#curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
#service docker start
#systemctl enable docker
2. clone the respo
#git clone https://github.com/infracloudio/csvserver
3. change directory to csvserver/solution
cd csvserver/solution
4. pull below images from docker repos
#docker pull infracloudio/csvserver:latest
#docker pull prom/prometheus:v2.22.0
#docker images
5. run container for image docker.io/infracloudio/csvserver:latest
#docker run docker.io/infracloudio/csvserver:latest
6. in case there is an error such as - cannot sety proprty TaskAccounting then restart systemd
#yum update systemd
7. run container again and onbserve the error, error might look like - error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory
#docker run -it docker.io/infracloudio/csvserver:latest -d
#docker ps -a
#docker logs <containerid>
8.create script to achive target

cat gencsv.sh
#!/bin/bash
if [ $# -eq 0 ]
then
	echo "no arguments provided"
	count=1
		while [ $count -lt 11 ]
		do
		number=$((RANDOM%100))
		echo "$count, $number" >> inputFile
		count=$((count+1))
		done
else
	echo "arguments provided"
	count=$1
	index=0
                while [ $count -gt 0 ]
		do
		number=$((RANDOM%100))
		index=$((index+1))
		echo "$index, $number" >> inputFile
                count=$((count-1))
 		done
fi
9. execute the script and run the container again by mouting the output file inside container , check the port on which service is running by going inside container
#bash gencsv.sh
#docker run -d -i -v /root/csvserver/solution/inputFile:/csvserver/inputdata docker.io/infracloudio/csvserver:latest
#docker exec -it da04e4123bb2 bash
10. stp the container
#docker stop da04e4123bb2
#docker ps
11.run the container do achive following
- The application is accessible on the host at http://localhost:9393
- Set the environment variable CSVSERVER_BORDER to have value Orange
#docker run -d -i -v /root/csvserver/solution/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER='Orange' infracloudio/csvserver:latest
#docker ps




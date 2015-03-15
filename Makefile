
IMAGE="rsmmr/clang:3.5"

all:

# Note, building the Docker image needs the default image size increased.
# On Fedora: add "--storage-opt dm.basesize=30G" to /etc/sysconfig/docker.

docker-build:
	docker build -t ${IMAGE} .

docker-run:
	docker run -i -t ${IMAGE}

docker-run-vrep:
	docker run -ti --rm ${IMAGE} /bin/sh -c 'cd /root/V-REP_PRO_EDU_V3_2_0_rev6_64_Linux/ && ./vrep.sh'   
#	docker run -ti --rm -e DISPLAY=$$DISPLAY -v /tmp/.Xll-unix:/tmp/.Xll-unix ${IMAGE} /bin/sh -c 'cd /root/V-REP_PRO_EDU_V3_2_0_rev6_64_Linux/ && ./vrep.sh'   

docker-push:
	docker push ${IMAGE}

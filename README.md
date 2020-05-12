# python-opencv-self-hello-world
self-build opencv

- use remote monitor???


- official tutorial [ref](https://docs.opencv.org/4.3.0/d7/d9f/tutorial_linux_install.html "opencv-4.3.0")

- files of opencv is under root

- build docker image
```shell
$ docker build \
--build-arg GID=$(id -g) \
--build-arg USER_NAME=${USER} \
--build-arg UID=$(id -u) \
--tag pt/python-opencv-self-hello-world:latest .
```

- run docker image as container
```shell
$ docker run \
--gpus all \
-it \
--volume ${PWD}:${PWD} \
--workdir ${PWD} \
--name python-opencv-self \
pt/python-opencv-self-hello-world:latest \
zsh
```

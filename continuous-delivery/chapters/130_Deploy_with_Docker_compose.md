# Deploy to Staging with Docker-Compose

In the previous chapter we have created our Docker image and pushed it to the Dockerhub registry.
Now, we will deploy our application using **docker-compose**.

## Pre-requisite

### Docker-Compose file Edit

This repo consists of one docker-compose file inside "build" directory.

```
version: "3"
networks:
  nw01:
    driver: bridge

services:
  app:
    image: <docker-hub-id>/<repo>:latest
    ports:
      - 7000:8080
    networks:
      - nw01
    depends_on:
      - mongo

  mongo:
    image: mongo:latest
    networks:
      - nw01
```

**Edit** this file. **Replace <docker-hub-id>/<repo>:latest** with your own values.

For me it looks like this. (**Note: This is my image name. Do not use this**)

![image](images/docker-compose/image.jpg)


## Create a Deploy Job

![job](images/docker-compose/job.jpg)

* Create a freestyle job called **Deploy**.

![trigger](images/docker-compose/trigger.jpg)

* In *Source Code Management* step, add **YOUR** git repository.

```
eg:
https://github.com/initcron/CI-Vertx.git
```

* In *Build Trigger*, add **Docker-Image** as a trigger.

![build](images/docker-compose/build.jpg)

* In Build step, add **Execute Shell** as a build step and put the following content.

```
cd build

docker-compose up -d
```

* Finally click on save.

----
:point_left: [**Prev** Chapter 12: Create Docker Image Job](https://github.com/schoolofdevops/learn-jenkins/blob/vertx-v1/continuous-delivery/chapters/120_create_docker_image.md)

# Docker 

This Docker guide is inspired by the official Docker documentation and practical insights from the open-source work of [vikashishere](https://github.com/vikashishere).

---

## 1. Why Docker is Needed?

- Docker helps developers build, package, and deploy applications quickly and efficiently.  
 - It solves the **“works on my machine”** problem by creating a consistent environment across dev, test, and production.  
 - *Docker containers encapsulate everything an app needs—code, libraries, dependencies—so it runs reliably anywhere.*

---

## 2. Benefits of Docker

- **Portability:**  
  Containers run the same across any environment (local, cloud, etc.).

- **Isolation:**  
  Each container is sandboxed; apps/services don’t conflict.

- **Scalability:**  
  Easily scale apps by adding/removing containers based on demand.

---

## 3. Docker vs Virtual Machine

| Docker Containers         | Virtual Machines          |
|--------------------------|--------------------------|
| Share host OS kernel     | Each VM has its own OS   |
| Lightweight, fast        | Heavy, slower startup    |
| Use less memory/CPU      | Consume more resources   |
| Great for microservices  | Useful for legacy/system apps |

**Summary:** Docker is lighter, faster, and more portable.

---

## 4. Docker Engine
Docker Engine is the core technology that powers Docker, consisting of three main parts:
- **Docker Daemon (`dockerd`)**: This is the background service running on the host machine. It is responsible for managing Docker objects like containers, images, networks, and volumes. The daemon listens for API requests and performs the actions you request.
- **REST API**: This allows communication between the Docker Daemon and the client. You can use the API to interact with Docker, such as creating containers or images.
- **Docker CLI (`docker`)**: The command-line interface (CLI) is the tool you use to interact with Docker. When you type commands like `docker run` or `docker build`, the CLI sends instructions to the Docker Daemon via the REST API.

<p align="center">
  <img src="https://media.licdn.com/dms/image/v2/D5610AQHciSNV3Sn19Q/image-shrink_1280/image-shrink_1280/0/1716836706478?e=2147483647&v=beta&t=ClmwiAsGY-1dm5HCQQ7_DOo8g7xxcbaqiZeIYDuIG8o" alt="Docker Engine Architecture" width="400" height="259" style="display: block; margin-left: auto; margin-right: auto;">
</p>

---

## 5. Docker Image 

A Docker image is a portable, read-only template used to create containers.  
It includes everything the software needs: OS, libraries, app code.

**Components:**
- **Base Image:** Starting point (can be `python:3.11-slim`, `ubuntu`, etc.).
- **Layers:** Each change (install, copy) adds a layer.
- **Metadata:** Image instructions (`CMD`, `ENTRYPOINT`, etc.).

---

## 6. Docker Image Lifecycle

1. **Creation:**  
   Build with a Dockerfile (or pull one via `docker pull`).

2. **Storage:**  
   Images stored locally; can push to registries.

3. **Distribution:**  
   Share via hub/private registries.

4. **Execution:**  
   Image becomes a live *container* when run.

---

## 7. Dockerfile

A blueprint for building images.  
Each instruction defines how the image is constructed.

**Key Instructions:**
- `FROM`: Set the base image.
- `WORKDIR`: Set directory for subsequent instructions.
- `COPY` / `ADD`: Add files from the host to the image.
- `RUN`: Run commands/install packages.
- `EXPOSE`: Inform about container listening ports.
- `CMD` / `ENTRYPOINT`: Default command when container starts.

---

## 8. Docker Container

A runtime instance of an image.  
Packages the app + dependencies in an isolated environment.

**Features:**
- Isolation (filesystem, processes, network)
- Ephemeral (can start, stop, destroy quickly)
- Lightweight (share host kernel, so resource efficient)

---

## 9. Docker Compose
Docker Compose is a tool for defining and running multi-container applications. Instead of manually running multiple docker run commands, Compose allows you to define all your containers, their configurations, networks, and volumes in a single YAML file, commonly named compose.yaml. This file defines each service of your application, including how to build images or which existing images to use, ports to expose, environment variables, and volumes.

---

## 10. Volumes
Docker volumes are persistent data storage managed by Docker that exist independently from a container’s lifecycle, enabling data to be saved and reused even if the container is stopped, removed, or recreated. Volumes store data outside the container's writable layer in a Docker-managed directory on the host, ensuring durability and separation between application logic and data.

**Types:**
  - Named Volumes: Explicitly created and referenced by name, ideal for persistent, reusable storage.
  - Anonymous Volumes: Created without a name, useful for temporary data but harder to manage.

**Bind Mounts:**
Bind mounts are another way to persist data by directly mounting a file or directory from the host machine into a container using its absolute path. Unlike volumes, bind mounts rely on the host machine’s filesystem and directory structure.

---

## 11. Docker Network
Docker networking enables containers to communicate with each other, the Docker host, and external networks by managing how network traffic is routed and isolated. Each container runs in its own network namespace, giving it an isolated network stack including interfaces and IP addresses.

**Common Docker Network Types:**
- Bridge (default): Creates an isolated internal network on the host for containers to communicate. Requires port mapping to expose containers externally.
- Host: Shares the host’s network stack with containers, removing network isolation. Useful for performance-critical applications but less secure.
- None: Disables networking for a container, providing complete isolation.

## 12. Docker Registry

System for storing and distributing images.

- **Public Registry:**  
  Docker Hub—anyone can share/pull images.

- **Private Registry:**  
  For internal team/enterprise distribution.

- **Cloud Registries:**  
  AWS ECR, GCP GCR, Azure ACR provide managed solutions.

**Benefits:**
- Centralized storage and sharing
- Version management for images
- Collaboration (share with community or organization)

---

## 13. Essential Docker Commands

### IMAGES

- **List all local images**
    ```
    docker images
    ```

- **Delete an image**
    ```
    docker rmi <image_id_or_name>
    ```

- **Remove unused images**
    ```
    docker image prune
    ```

- **Build an image from a Dockerfile**
    ```
    docker build -t <image_name>:<version> .
    ```
    _Version tag is optional_

- **Build image without cache**
    ```
    docker build -t <image_name>:<version> . --no-cache
    ```

### CONTAINERS

- **List all local containers (running & stopped)**
    ```
    docker ps -a
    ```

- **List all running containers**
    ```
    docker ps
    ```

- **Create & run a new container**
    ```
    docker run <image_name>
    ```
    _If image not available locally, it’ll be pulled from DockerHub automatically._

- **Run container in background**
    ```
    docker run -d <image_name>
    ```
    | Flag | Meaning            | What Happens                                      |
    |------|--------------------|---------------------------------------------------|
    | -d   | Detached mode      | Runs container in background (returns prompt)     |
    | none | Attached (default) | Runs container in terminal (shows logs)           |

- **Run container with custom name**
    ```
    docker run --name <container_name> <image_name>
    ```

- **Port binding**
    ```
    docker run -p <host_port>:<container_port> <image_name>
    ```

- **Set environment variables**
    ```
    docker run -e <VAR_NAME>=<value> <image_name>
    ```

- **Run interactive shell in a running container**
    ```
    docker exec -it <container_id_or_name> /bin/bash
    ```

### Docker Compose

- **To start all the services defined in your compose.yaml file**
    ```
    docker compose up
    ```
    _for custom .yaml file_
    ```
    docker compose -f fileName.yaml up -d
    ```

- **To stop and remove the running services**
    ```
    docker compose down 
    ```
    _for custom .yaml file_
    ```
    docker compose -f fileName.yaml down
    ```

### DOCKER HUB

- **Pull an image from DockerHub**
    ```
    docker pull <image_name>
    ```

- **Publish an image to DockerHub**
    ```
    docker push <username>/<image_name>
    ```

- **Login into DockerHub**
    ```
    docker login -u <username>
    ```
    _Or simply:_
    ```
    docker login
    ```

- **Logout from DockerHub**
    ```
    docker logout
    ```

- **Search for an image on DockerHub**
    ```
    docker search <keyword>
    ```

### VOLUMES

- **List all volumes**
    ```
    docker volume ls
    ```

- **Create new named volume**
    ```
    docker volume create <volume_name>
    ```

- **Delete a named volume**
    ```
    docker volume rm <volume_name>
    ```

- **Mount named volume with running container**
    ```
    docker run --volume <volume_name>:<container_path> <image_name>
    ```
    _or using `--mount`:_
    ```
    docker run --mount type=volume,src=<volume_name>,dest=<container_path> <image_name>
    ```

- **Mount anonymous volume**
    ```
    docker run --volume <container_path> <image_name>
    ```

- **Create a bind mount**
    ```
    docker run --volume <host_path>:<container_path> <image_name>
    ```
    _or using `--mount`:_
    ```
    docker run --mount type=bind,src=<host_path>,dest=<container_path> <image_name>
    ```

- **Remove unused local volumes**
    ```
    docker volume prune
    ```
    _This removes anonymous (unused) volumes._

### NETWORK

- **List all networks**
    ```
    docker network ls
    ```

- **Create a network**
    ```
    docker network create <network_name>
    ```

- **Remove a network**
    ```
    docker network rm <network_name>
    ```

- **Remove all unused networks**
    ```
    docker network prune
    ```
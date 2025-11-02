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

## 9. Docker Registry

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

## 10. Essential Docker Commands

- **Build an image:**
    ```
    docker build -t my-app .
    ```
- **Tag an image for a repository:**
    ```
    docker tag my-app username/my-app:latest
    ```
- **Run container from image, map port:**
    ```
    docker run -d -p 8080:80 my-app
    ```
    | Flag | Meaning            | What Happens                                      |
    |------|--------------------|---------------------------------------------------|
    | -d   | Detached mode      | Runs container in background (returns prompt)     |
    | none | Attached (default) | Runs container in terminal (shows logs)           |
- **List running containers:**
    ```
    docker ps
    ```
- **Stop and remove a container:**
    ```
    docker stop <container>
    docker rm <container>
    ```
- **Remove an image:**
    ```
    docker rmi my-app
    ```
- **List images and volumes:**
    ```
    docker images
    docker volume ls
    ```
- **See container logs:**
    ```
    docker logs <container>
    ```




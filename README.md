# Inception

## 📌 Description

Inception is a system administration project focused on building a secure, containerized web infrastructure using Docker and Docker Compose.

The objective is to deploy a multi-service architecture composed of:

- NGINX (TLS-secured reverse proxy)
- WordPress (PHP-FPM)
- MariaDB
- Docker named volumes for persistent storage
- A dedicated Docker network

All services are built from scratch using custom Dockerfiles and orchestrated inside a virtual machine.

---

## 🏗 Architecture Overview

The infrastructure follows a modular container-based design:

### NGINX
- Single entry point
- HTTPS only (TLSv1.2 / TLSv1.3)
- Reverse proxy to WordPress

### WordPress
- Runs with PHP-FPM
- Communicates internally with MariaDB

### MariaDB
- Dedicated database container
- Persistent data stored via Docker named volume

### Docker Volumes
- Database storage
- WordPress website files
- Stored under `/home/<login>/data` on the host

### Docker Network
- Isolated internal communication between containers
- No host networking

---

## ⚙️ Technologies Used

- Docker  
- Docker Compose  
- NGINX  
- WordPress  
- MariaDB  
- Linux  
- TLS/SSL  

---

## 🚀 Installation & Usage

### 1️⃣ Prerequisites

- Linux environment (Virtual Machine required)
- Docker
- Docker Compose
- Make

### 2️⃣ Setup

Clone the repository:

```bash
git clone https://github.com/ennaciririda/Inception.git
cd Inception
```

Configure your `.env` file inside `srcs/`:

```env
DOMAIN_NAME=yourlogin.42.fr
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=your_database
```

Make sure your domain points to your local IP address in `/etc/hosts`:

```
127.0.0.1 yourlogin.42.fr
```

### 3️⃣ Build & Run

```bash
make
```

This will:
- Build all Docker images
- Create volumes
- Create network
- Start containers

### 4️⃣ Stop Services

```bash
make down
```

### 5️⃣ Clean Everything

```bash
make fclean
```

---

## 🔐 Security Practices

- No credentials stored inside Dockerfiles
- Sensitive data managed via `.env`
- HTTPS enforced (port 443 only)
- No `latest` tags used
- No pre-built images pulled (except base Alpine/Debian)

---

## 📦 Design Choices

### 🔹 Virtual Machines vs Docker
Virtual Machines provide full OS virtualization.  
Docker provides lightweight containerized services sharing the host kernel.  
Docker was chosen for efficiency, portability, and scalability.

### 🔹 Secrets vs Environment Variables
Environment variables are simple and flexible.  
Docker secrets provide stronger protection for sensitive data.  
This project uses `.env` while respecting security constraints.

### 🔹 Docker Network vs Host Network
Docker network ensures container isolation and secure internal communication.  
Host networking was forbidden and reduces isolation.

### 🔹 Docker Volumes vs Bind Mounts
Named volumes provide managed persistent storage.  
Bind mounts depend directly on host filesystem paths.  
Named volumes were required for database and WordPress persistence.

---

## 📂 Project Structure

```
Makefile
srcs/
 ├── docker-compose.yml
 ├── .env
 └── requirements/
     ├── nginx/
     ├── wordpress/
     └── mariadb/
```

---

## 🧠 What I Learned

- Writing production-ready Dockerfiles
- Container orchestration with Docker Compose
- TLS configuration with NGINX
- Service isolation and networking
- Persistent storage management
- Infrastructure design fundamentals

# 🐳 Docker Setup Guide for Quiz Application

## 📋 **What is Docker?**

Docker is a platform that packages your application and all its dependencies into **containers** - lightweight, portable units that run consistently across any environment.

**Benefits for your Quiz App:**
- ✅ **Consistency**: Same environment locally and in production
- ✅ **Easy Deployment**: One command to run everything
- ✅ **Isolation**: Each service runs independently
- ✅ **Scalability**: Easy to scale individual services

## 🛠️ **Docker Setup Options**

### **Option 1: Quick Start with Docker Compose (Recommended)**
Run everything with one command - all services + database

### **Option 2: Individual Containers**
Build and run each service separately

### **Option 3: Production Deployment**
Deploy to cloud platforms like Railway, AWS, etc.

---

## 🚀 **Option 1: Docker Compose (All-in-One)**

### **Step 1: Install Docker**
1. Download Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Install and start Docker Desktop
3. Verify installation:
   ```powershell
   docker --version
   docker-compose --version
   ```

### **Step 2: Run Your Application**
```powershell
# Navigate to your project
cd "d:\OnlineQuizApplication"

# Start everything (database + all services + frontend)
docker-compose up -d

# View logs
docker-compose logs -f

# Stop everything
docker-compose down
```

**That's it! Your app will be running at:**
- 🌐 **Frontend**: http://localhost:3000
- 🔐 **Auth Service**: http://localhost:8080
- 📝 **Question Service**: http://localhost:8081
- 📊 **Result Service**: http://localhost:8082
- 🗄️ **Database**: PostgreSQL on port 5432

---

## 🔧 **Option 2: Individual Docker Commands**

### **Build Images:**
```powershell
# Build Auth Service
cd "d:\OnlineQuizApplication\auth-quiz-service"
docker build -t quiz-auth-service .

# Build Question Service
cd "..\question-bank-service"
docker build -t quiz-question-service .

# Build Result Service
cd "..\result-service"
docker build -t quiz-result-service .
```

### **Run Database:**
```powershell
docker run --name quiz-postgres \
  -e POSTGRES_DB=quiz_application \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  -d postgres:15
```

### **Run Services:**
```powershell
# Run Auth Service
docker run --name quiz-auth \
  -p 8080:8080 \
  --link quiz-postgres:postgres \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/quiz_application \
  -d quiz-auth-service

# Run Question Service
docker run --name quiz-questions \
  -p 8081:8081 \
  --link quiz-postgres:postgres \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/quiz_application \
  -d quiz-question-service

# Run Result Service
docker run --name quiz-results \
  -p 8082:8082 \
  --link quiz-postgres:postgres \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/quiz_application \
  -d quiz-result-service
```

### **Serve Frontend:**
```powershell
# Simple HTTP server for frontend
cd "d:\OnlineQuizApplication\online-quiz-frontend"
docker run --name quiz-frontend \
  -p 3000:80 \
  -v ${PWD}:/usr/share/nginx/html \
  -d nginx
```

---

## 📊 **Docker Commands Cheat Sheet**

### **Container Management:**
```powershell
# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop <container-name>

# Remove container
docker rm <container-name>

# View logs
docker logs <container-name>

# Execute command in container
docker exec -it <container-name> bash
```

### **Image Management:**
```powershell
# List images
docker images

# Remove image
docker rmi <image-name>

# Pull image from registry
docker pull <image-name>

# Build image
docker build -t <image-name> .
```

### **Docker Compose:**
```powershell
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild and start
docker-compose up --build -d

# Scale a service
docker-compose up -d --scale auth-service=3
```

---

## 🌐 **Option 3: Production Deployment**

### **Deploy to Railway:**
Railway automatically detects and builds your Dockerfiles:
1. Connect GitHub repository
2. Railway builds using your existing Dockerfiles
3. Automatically provisions PostgreSQL
4. Sets up networking between services

### **Deploy to AWS/Azure:**
```powershell
# Build for production
docker build -t your-registry/quiz-auth .
docker push your-registry/quiz-auth

# Deploy using container services
# (AWS ECS, Azure Container Instances, etc.)
```

---

## 🔍 **Troubleshooting**

### **Common Issues:**

**1. Port Already in Use:**
```powershell
# Find process using port
netstat -ano | findstr :8080

# Kill process
taskkill /PID <process-id> /F
```

**2. Container Won't Start:**
```powershell
# Check logs
docker logs <container-name>

# Check container status
docker inspect <container-name>
```

**3. Database Connection Issues:**
```powershell
# Test database connection
docker exec -it quiz-postgres psql -U postgres -d quiz_application
```

**4. Build Failures:**
```powershell
# Clean build
docker system prune -a
docker-compose build --no-cache
```

---

## 🎯 **Best Practices**

### **Development:**
- Use `docker-compose` for local development
- Mount volumes for live code reloading
- Use environment-specific configs

### **Production:**
- Use multi-stage builds for smaller images
- Set proper resource limits
- Use health checks
- Implement proper logging

### **Security:**
- Don't include secrets in Dockerfiles
- Use non-root users in containers
- Scan images for vulnerabilities
- Use official base images

---

## 🚀 **Quick Start Summary**

**For Beginners (Easiest):**
```powershell
cd "d:\OnlineQuizApplication"
docker-compose up -d
```

**For Advanced Users:**
Build individual services and customize deployment

**For Production:**
Use Railway/AWS with existing Dockerfiles

---

**Your Quiz Application is now fully containerized and ready for any deployment scenario!** 🎉

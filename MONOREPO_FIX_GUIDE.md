# 🔧 **BACK4APP MONOREPO CONFIGURATION GUIDE**

## 🚨 **Problem Identified:**
Back4App is trying to build the entire repository for each microservice, causing build context issues.

## ✅ **SOLUTION: Proper Monorepo Configuration**

### **Current Repository Structure:**
```
Quiz-Application/
├── auth-quiz-service/
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
├── question-bank-service/
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
├── result-service/
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
└── online-quiz-frontend/
    ├── index.html
    ├── js/
    └── css/
```

---

## 🔧 **BACK4APP CONFIGURATION FIX:**

### **For Each Service Deployment:**

#### **Auth Service Configuration:**
1. **Repository**: `Quiz-Application`
2. **Branch**: `main`
3. **Root Directory**: `auth-quiz-service` ✅
4. **Build Context**: `./auth-quiz-service`
5. **Dockerfile Path**: `./Dockerfile` (relative to root directory)

#### **Question Service Configuration:**
1. **Repository**: `Quiz-Application`
2. **Branch**: `main`
3. **Root Directory**: `question-bank-service` ✅
4. **Build Context**: `./question-bank-service`
5. **Dockerfile Path**: `./Dockerfile` (relative to root directory)

#### **Result Service Configuration:**
1. **Repository**: `Quiz-Application`
2. **Branch**: `main`
3. **Root Directory**: `result-service` ✅
4. **Build Context**: `./result-service`
5. **Dockerfile Path**: `./Dockerfile` (relative to root directory)

---

## 🐳 **DOCKERFILE VERIFICATION:**

### **Check Current Dockerfiles:**
Each service Dockerfile should work within its own directory context.

### **Auth Service Dockerfile (✅ Correct):**
```dockerfile
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .          # Copies from auth-quiz-service/pom.xml
COPY src ./src          # Copies from auth-quiz-service/src
RUN mvn clean package -DskipTests
...
```

---

## 🔄 **ALTERNATIVE: Docker Compose for Local Testing**

### **Test Your Setup Locally First:**
```yaml
# docker-compose.yml (in root directory)
version: '3.8'
services:
  auth-service:
    build: ./auth-quiz-service
    ports: [8080:8080]
  
  question-service:
    build: ./question-bank-service
    ports: [8081:8081]
  
  result-service:
    build: ./result-service
    ports: [8082:8082]
```

### **Test Command:**
```bash
docker-compose up --build
```

---

## 🚨 **IF MONOREPO STILL FAILS:**

### **Option A: Use GitHub Submodules**
```bash
# Create separate repos and link them
git submodule add https://github.com/Divyansh-Wadhwa/auth-service.git auth-quiz-service
git submodule add https://github.com/Divyansh-Wadhwa/question-service.git question-bank-service
git submodule add https://github.com/Divyansh-Wadhwa/result-service.git result-service
```

### **Option B: Create Separate Repositories (Recommended if monorepo fails)**

#### **Step 1: Create Individual Repositories**
1. **auth-quiz-service** repository
2. **question-bank-service** repository  
3. **result-service** repository
4. **quiz-frontend** repository

#### **Step 2: Split Current Repository**
```bash
# For Auth Service
git subtree push --prefix=auth-quiz-service origin auth-service-branch

# For Question Service
git subtree push --prefix=question-bank-service origin question-service-branch

# For Result Service
git subtree push --prefix=result-service origin result-service-branch
```

---

## 🎯 **RECOMMENDED IMMEDIATE FIX:**

### **Step 1: Verify Back4App Settings**
For each service in Back4App dashboard:

1. **Go to Settings → Build Configuration**
2. **Verify Root Directory is set correctly:**
   - Auth: `auth-quiz-service`
   - Question: `question-bank-service`
   - Result: `result-service`

3. **Check Build Logs for Context Issues**

### **Step 2: If Build Still Fails, Use Alternative Dockerfile Locations**

Let me create root-level Dockerfiles that reference the correct build context:

#### **Create Root-Level Dockerfiles:**
```dockerfile
# Dockerfile.auth (in repository root)
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY auth-quiz-service/pom.xml .
COPY auth-quiz-service/src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/auth-quiz-service-1.0.0.jar app.jar
EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=back4app
CMD ["java", "-jar", "app.jar"]
```

---

## 🔄 **TESTING YOUR SETUP:**

### **Local Test (Recommended First):**
```bash
# Test individual service builds
cd auth-quiz-service
docker build -t auth-service .
docker run -p 8080:8080 auth-service

cd ../question-bank-service  
docker build -t question-service .
docker run -p 8081:8081 question-service

cd ../result-service
docker build -t result-service .
docker run -p 8082:8082 result-service
```

### **If Local Build Works:**
✅ Your Dockerfiles are correct
✅ Issue is with Back4App configuration
✅ Follow monorepo configuration steps above

### **If Local Build Fails:**
❌ Dockerfile issues need fixing
❌ Path/context problems
❌ Dependencies missing

---

## 🎯 **IMMEDIATE ACTION PLAN:**

1. **✅ Test locally first** (docker build in each service directory)
2. **🔧 Fix Back4App root directory settings**
3. **📝 Check build logs** for specific errors
4. **🔄 If still failing, split repositories**

**Would you like me to help you test the local build first, or shall we create separate repositories for each service?**

# 🗄️ Database Setup Guide

## 🚨 **IMPORTANT CHANGES MADE**

Your application has been updated from **MySQL** to **PostgreSQL** with a **single shared database** for better production deployment.

## 📋 **What Changed:**

### ✅ **Before (Issues):**
- ❌ MySQL with 3 separate databases (`quiz_app`, `question_bank`, `result_service`)
- ❌ Inconsistent with production PostgreSQL setup
- ❌ Complex deployment with multiple databases

### ✅ **After (Fixed):**
- ✅ Single PostgreSQL database: `quiz_application`
- ✅ All 3 services share the same database
- ✅ Consistent local and production setup
- ✅ Simplified deployment

## 🔧 **Local Development Setup**

### **Step 1: Install PostgreSQL**

**Windows:**
1. Download PostgreSQL from: https://www.postgresql.org/download/windows/
2. Run installer and set password for `postgres` user
3. Default port: `5432` (keep default)

**Or use Docker:**
```powershell
docker run --name quiz-postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=quiz_application -p 5432:5432 -d postgres:15
```

### **Step 2: Create Database**

**Option A - Using pgAdmin (GUI):**
1. Open pgAdmin (comes with PostgreSQL)
2. Connect to localhost
3. Create new database: `quiz_application`

**Option B - Using Command Line:**
```powershell
# Connect to PostgreSQL
psql -U postgres -h localhost

# Create database
CREATE DATABASE quiz_application;

# Exit
\q
```

### **Step 3: Run Database Schema**
```powershell
# Navigate to your project
cd "d:\OnlineQuizApplication"

# Run the schema file
psql -U postgres -h localhost -d quiz_application -f database/schema.sql
```

### **Step 4: Update Local Configuration**
The following files have been updated for you:
- ✅ `auth-quiz-service/pom.xml` - PostgreSQL dependency added
- ✅ `question-bank-service/pom.xml` - PostgreSQL dependency added  
- ✅ `result-service/pom.xml` - PostgreSQL dependency added
- ✅ All `application.properties` files updated

**Current local database settings:**
```properties
Database: quiz_application
Username: postgres  
Password: password
Port: 5432
Host: localhost
```

## 🌐 **Production Setup (Railway)**

Railway will automatically:
- ✅ Create PostgreSQL database
- ✅ Generate connection credentials
- ✅ Set environment variables
- ✅ Share database across all 3 services

## 📊 **Database Schema Overview**

Your database now contains these tables:
- `users` - User accounts and authentication
- `questions` - Quiz questions with options
- `quizzes` - Quiz definitions
- `quiz_questions` - Links questions to quizzes
- `quiz_attempts` - User quiz results
- `user_answers` - Individual question answers

## 🔄 **Migration from MySQL (Optional)**

If you have existing MySQL data to migrate:

### **Export from MySQL:**
```bash
mysqldump -u root -p quiz_app > quiz_data.sql
mysqldump -u root -p question_bank >> quiz_data.sql  
mysqldump -u root -p result_service >> quiz_data.sql
```

### **Import to PostgreSQL:**
1. Clean up the SQL file (remove MySQL-specific syntax)
2. Import: `psql -U postgres -d quiz_application -f quiz_data.sql`

## ✅ **Testing Your Setup**

### **1. Test Database Connection:**
```powershell
# Test connection
psql -U postgres -h localhost -d quiz_application -c "SELECT version();"
```

### **2. Start Your Services:**
```powershell
# Terminal 1 - Auth Service
cd "d:\OnlineQuizApplication\auth-quiz-service"
./mvnw spring-boot:run

# Terminal 2 - Question Service  
cd "d:\OnlineQuizApplication\question-bank-service"
./mvnw spring-boot:run

# Terminal 3 - Result Service
cd "d:\OnlineQuizApplication\result-service"  
./mvnw spring-boot:run
```

### **3. Check Logs:**
Look for:
- ✅ "Connected to PostgreSQL database"
- ✅ "Hibernate: create table..." messages
- ❌ No connection errors

## 🆘 **Troubleshooting**

### **Common Issues:**

**1. "Connection refused"**
- ❌ PostgreSQL not running
- ✅ Start PostgreSQL service or Docker container

**2. "Authentication failed"**
- ❌ Wrong username/password
- ✅ Check your PostgreSQL installation credentials

**3. "Database does not exist"**
- ❌ Database not created
- ✅ Run: `CREATE DATABASE quiz_application;`

**4. "Driver not found"**
- ❌ Missing PostgreSQL dependency
- ✅ Run: `./mvnw clean install` in each service

### **Database Credentials:**
- **Local**: `postgres` / `password` / `quiz_application`
- **Production**: Railway will provide automatically

## 🎯 **Next Steps**

1. ✅ Install PostgreSQL locally
2. ✅ Create `quiz_application` database
3. ✅ Run the schema.sql file
4. ✅ Test all 3 services locally
5. ✅ Deploy to Railway (database will be auto-created)

---
**Your application is now ready for both local development and production deployment with a consistent PostgreSQL setup!** 🚀

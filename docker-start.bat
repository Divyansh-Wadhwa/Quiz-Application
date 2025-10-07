@echo off
REM Quick Docker Setup Script for Quiz Application (Windows)

echo 🐳 Starting Quiz Application with Docker...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker Desktop first.
    pause
    exit /b 1
)

REM Check if docker-compose is available
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ docker-compose not found. Please install Docker Desktop.
    pause
    exit /b 1
)

echo ✅ Docker is running
echo.

REM Stop any existing containers
echo 🛑 Stopping existing containers...
docker-compose down

REM Build and start all services
echo 🚀 Building and starting all services...
docker-compose up --build -d

echo.
echo ⏳ Waiting for services to start...
timeout /t 10 /nobreak >nul

REM Check service health
echo.
echo 🔍 Checking service status...

REM Check database
docker exec quiz-postgres pg_isready -U postgres >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Database: Running
) else (
    echo ❌ Database: Not ready
)

REM Check services (simplified for Windows batch)
docker ps --format "table {{.Names}}\t{{.Status}}" | findstr "quiz-auth-service" | findstr "Up" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Auth Service: Running
) else (
    echo ❌ Auth Service: Not running
)

docker ps --format "table {{.Names}}\t{{.Status}}" | findstr "quiz-question-service" | findstr "Up" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Question Service: Running
) else (
    echo ❌ Question Service: Not running
)

docker ps --format "table {{.Names}}\t{{.Status}}" | findstr "quiz-result-service" | findstr "Up" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Result Service: Running
) else (
    echo ❌ Result Service: Not running
)

echo.
echo 🌐 Your Quiz Application is ready!
echo.
echo 📱 Frontend:        http://localhost:3000
echo 🔐 Auth Service:    http://localhost:8080
echo 📝 Question Service: http://localhost:8081
echo 📊 Result Service:  http://localhost:8082
echo 🗄️ Database:        localhost:5432
echo.
echo 💡 Commands:
echo    View logs:       docker-compose logs -f
echo    Stop services:   docker-compose down
echo    Restart:         docker-compose restart
echo.

REM Open browser
set /p choice="🌐 Open application in browser? (y/n): "
if /i "%choice%"=="y" (
    start http://localhost:3000
)

echo 🎉 Setup complete!
pause

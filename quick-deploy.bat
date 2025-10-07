@echo off
REM Quick Deployment Reference Script for Windows
REM Copy and paste these commands step by step

echo 🚀 QUIZ APPLICATION - DEPLOYMENT COMMANDS
echo ==========================================
echo.

echo 📋 PHASE 1: GitHub Setup
echo ------------------------
echo 1. Create repo at: https://github.com/new
echo    - Name: online-quiz-application
echo    - Public repository
echo    - DON'T initialize with files
echo.
echo 2. Run these commands:
echo    git branch -M main
echo    git remote add origin https://github.com/YOUR_USERNAME/online-quiz-application.git
echo    git push -u origin main
echo.

echo 📋 PHASE 2: Railway Deployment
echo ------------------------------
echo 1. Go to: https://railway.app
echo 2. Sign up with GitHub
echo 3. For EACH service (auth, question, result):
echo    - New Project → Deploy from GitHub
echo    - Select: online-quiz-application
echo    - Set Root Directory:
echo      * auth-quiz-service
echo      * question-bank-service
echo      * result-service
echo 4. Add PostgreSQL database to first service
echo 5. Copy database vars to other services
echo 6. Copy all service URLs
echo.

echo 📋 PHASE 3: Netlify Deployment
echo ------------------------------
echo 1. Go to: https://netlify.com
echo 2. New site from Git → GitHub
echo 3. Select: online-quiz-application
echo 4. Base directory: online-quiz-frontend
echo 5. Deploy and copy URL
echo.

echo 📋 PHASE 4: Update Configuration
echo --------------------------------
echo 1. Edit: online-quiz-frontend/js/production-config.js
echo 2. Replace URLs with your Railway URLs
echo 3. Commit and push:
echo    git add .
echo    git commit -m "Update production URLs"
echo    git push
echo.

echo 📋 PHASE 5: Test Everything
echo ---------------------------
echo 1. Visit your Netlify URL
echo 2. Test user registration
echo 3. Test quiz creation
echo 4. Test quiz taking
echo 5. Test admin panels
echo.

echo 🎉 DONE! Your app is live on the internet!
echo.
echo 📚 Detailed guides available:
echo - PUBLICATION_STEPS.md (complete guide)
echo - DEPLOYMENT_GUIDE.md (technical details)
echo - DATABASE_SETUP.md (database info)
echo - DOCKER_GUIDE.md (containerization)
echo.
pause

@echo off
echo 🚀 BACK4APP DEPLOYMENT CHECKLIST
echo ================================
echo.

echo ✅ PREPARATION COMPLETED:
echo    - Back4App configuration files created
echo    - Dockerfiles updated for Back4App
echo    - Environment variables configured
echo    - Database schema ready
echo.

echo 📋 YOUR DEPLOYMENT STEPS:
echo.

echo 🔥 STEP 1: Create Back4App Account
echo    1. Go to: https://www.back4app.com/
echo    2. Sign up with GitHub
echo    3. Verify email
echo.

echo 🔥 STEP 2: Deploy Auth Service
echo    1. Click "Build new app" → "Container App"
echo    2. Name: quiz-auth-service
echo    3. Connect GitHub repo: Quiz-Application
echo    4. Root directory: auth-quiz-service
echo    5. Port: 8080
echo    6. Add PostgreSQL database
echo    7. Environment variables:
echo       SPRING_PROFILES_ACTIVE=back4app
echo       JWT_SECRET=ZmFrZV9zdXBlcl9sb25nX3NlY3JldF9rZXlfMzJfY2hhcnNfbWluaW11bQ==
echo    8. Deploy and copy URL
echo.

echo 🔥 STEP 3: Deploy Question Service
echo    1. New app: quiz-question-service
echo    2. Root directory: question-bank-service
echo    3. Port: 8081
echo    4. Link same database from Auth Service
echo    5. Deploy and copy URL
echo.

echo 🔥 STEP 4: Deploy Result Service
echo    1. New app: quiz-result-service
echo    2. Root directory: result-service
echo    3. Port: 8082
echo    4. Link same database
echo    5. Deploy and copy URL
echo.

echo 🔥 STEP 5: Update Frontend URLs
echo    1. Edit: online-quiz-frontend/js/production-config.js
echo    2. Replace with your Back4App URLs:
echo       window.PRODUCTION_AUTH_API = 'https://quiz-auth-service.b4a.run/api/auth';
echo       window.PRODUCTION_QUESTION_API = 'https://quiz-question-service.b4a.run/api/questions';
echo       window.PRODUCTION_RESULT_API = 'https://quiz-result-service.b4a.run/api/results';
echo.

echo 🔥 STEP 6: Deploy Frontend on Netlify
echo    1. Go to: https://netlify.com
echo    2. New site from Git → Quiz-Application
echo    3. Base directory: online-quiz-frontend
echo    4. Deploy
echo.

echo 🔥 STEP 7: Update CORS Settings
echo    1. Go to each Back4App service
echo    2. Add environment variable:
echo       CORS_ALLOWED_ORIGINS=https://your-netlify-url.netlify.app
echo    3. Restart services
echo.

echo 🔥 STEP 8: Test Everything
echo    1. Visit your Netlify URL
echo    2. Register new user
echo    3. Login
echo    4. Create quiz
echo    5. Take quiz
echo    6. Check results
echo.

echo 💰 EXPECTED COSTS:
echo    - Back4App: FREE (25,000 requests/month)
echo    - Netlify: FREE (100GB bandwidth/month)
echo    - Total: $0/month
echo.

echo 📊 MONITORING:
echo    - Back4App Dashboard: Monitor API usage
echo    - Database usage: Check storage (1GB free)
echo    - Performance: Check app metrics
echo.

echo 🎉 RESULT: Your Quiz App will be live at:
echo    - Frontend: https://your-app.netlify.app
echo    - Auth API: https://quiz-auth-service.b4a.run
echo    - Question API: https://quiz-question-service.b4a.run
echo    - Result API: https://quiz-result-service.b4a.run
echo.

echo 🚀 Ready to start? Go to https://www.back4app.com/
echo.
pause

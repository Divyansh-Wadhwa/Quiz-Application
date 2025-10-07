# 🚀 Quiz Application Deployment Guide

## ✅ Pre-deployment Checklist
All necessary files have been created and configured for you:
- [x] Production configuration files added
- [x] CORS settings updated for production
- [x] Railway deployment files created
- [x] Frontend config updated for auto-detection
- [x] Docker files ready (optional)

## 📋 Step-by-Step Deployment Instructions

### Phase 1: Prepare Your Repository

1. **Initialize Git Repository** (if not already done):
   ```bash
   cd "d:\OnlineQuizApplication"
   git init
   git add .
   git commit -m "Initial commit - Quiz Application ready for deployment"
   ```

2. **Create GitHub Repository**:
   - Go to https://github.com/new
   - Repository name: `online-quiz-application`
   - Description: `Full-stack quiz application with microservices`
   - Public or Private: Choose based on your preference
   - Click "Create repository"

3. **Push to GitHub**:
   ```bash
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/online-quiz-application.git
   git push -u origin main
   ```

### Phase 2: Deploy Backend Services on Railway

#### Service 1: Auth Service
1. Go to https://railway.app and sign up/login
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your `online-quiz-application` repository
4. **Important**: Click "Configure" and set:
   - **Root Directory**: `auth-quiz-service`
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -Dspring.profiles.active=prod -Dserver.port=$PORT -jar target/auth-quiz-service-1.0.0.jar`
5. Add PostgreSQL database:
   - Go to your project dashboard
   - Click "New" → "Database" → "Add PostgreSQL"
6. **Copy the generated URL** (e.g., `https://auth-service-production-abc123.up.railway.app`)

#### Service 2: Question Bank Service
1. Click "New Project" → "Deploy from GitHub repo"
2. Select your `online-quiz-application` repository again
3. **Important**: Click "Configure" and set:
   - **Root Directory**: `question-bank-service`
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -Dspring.profiles.active=prod -Dserver.port=$PORT -jar target/question-bank-service-1.0.0.jar`
4. **Connect to the same PostgreSQL database** from Service 1:
   - Go to Variables tab
   - Add the same database variables from your Auth Service
5. **Copy the generated URL** (e.g., `https://question-service-production-def456.up.railway.app`)

#### Service 3: Result Service
1. Click "New Project" → "Deploy from GitHub repo"
2. Select your `online-quiz-application` repository again
3. **Important**: Click "Configure" and set:
   - **Root Directory**: `result-service`
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -Dspring.profiles.active=prod -Dserver.port=$PORT -jar target/result-service-1.0.0.jar`
4. **Connect to the same PostgreSQL database** from Service 1
5. **Copy the generated URL** (e.g., `https://result-service-production-ghi789.up.railway.app`)

### Phase 3: Update Frontend Configuration

1. **Create production config file**:
   - Copy `deployment-config.js` to `production-config.js`
   - Update with your actual Railway URLs:
   ```javascript
   window.PRODUCTION_AUTH_API = 'https://YOUR_ACTUAL_AUTH_URL.railway.app/api/auth';
   window.PRODUCTION_QUESTION_API = 'https://YOUR_ACTUAL_QUESTION_URL.railway.app/api/questions';
   window.PRODUCTION_RESULT_API = 'https://YOUR_ACTUAL_RESULT_URL.railway.app/api/results';
   ```

2. **Add the production config to all HTML files**:
   Add this line BEFORE the existing config.js script tag in ALL HTML files:
   ```html
   <script src="js/production-config.js"></script>
   ```

### Phase 4: Deploy Frontend on Netlify

1. Go to https://netlify.com and sign up/login
2. **Option A - Drag & Drop**:
   - Zip your `online-quiz-frontend` folder
   - Drag and drop the zip file to Netlify
   
3. **Option B - GitHub Integration** (Recommended):
   - Click "New site from Git"
   - Choose GitHub and select your repository
   - **Build settings**:
     - Base directory: `online-quiz-frontend`
     - Build command: (leave empty)
     - Publish directory: `.` (current directory)

4. **Copy your Netlify URL** (e.g., `https://amazing-quiz-app-123.netlify.app`)

### Phase 5: Final Configuration

1. **Update CORS settings** in Railway:
   - Go to each Railway service
   - Add environment variable: `ALLOWED_ORIGINS=https://your-netlify-url.netlify.app`

2. **Test your application**:
   - Visit your Netlify URL
   - Try registering a new user
   - Create a quiz
   - Take the quiz
   - Check admin panel

### Phase 6: Custom Domain (Optional)

1. **Buy a domain** (e.g., from Namecheap, GoDaddy)
2. **Set up custom domain on Netlify**:
   - Go to Site settings → Domain management
   - Add custom domain
   - Update DNS records as instructed

## 🎯 Expected Results

After successful deployment, you'll have:
- ✅ **Frontend**: https://your-app.netlify.app
- ✅ **Auth Service**: https://auth-service-xxx.railway.app
- ✅ **Question Service**: https://question-service-xxx.railway.app  
- ✅ **Result Service**: https://result-service-xxx.railway.app
- ✅ **Database**: PostgreSQL on Railway

## 💰 Estimated Costs
- **Free Tier**: $0/month (Railway free tier + Netlify free)
- **With Custom Domain**: ~$12-15/year for domain
- **Scaling**: Railway charges per usage after free tier

## 🔧 Troubleshooting

### Common Issues:
1. **CORS Errors**: Make sure ALLOWED_ORIGINS includes your Netlify URL
2. **Database Connection**: Ensure all services use the same PostgreSQL instance
3. **API URLs**: Double-check your production-config.js has correct URLs
4. **Build Failures**: Check Railway logs for detailed error messages

### Get Help:
- Check Railway deployment logs
- Use browser developer tools for frontend issues
- Test API endpoints directly using Postman or curl

## 🎉 Success!
Once deployed, share your live quiz application URL with friends and colleagues!

---
*This deployment guide was automatically generated for your Quiz Application*

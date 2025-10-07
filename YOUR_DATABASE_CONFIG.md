# Your Supabase DATABASE_URL Configuration

## Password: 123456789@abc#

### ⚠️ URL Encoding Required
Your password contains special characters (`@` and `#`) that need to be URL-encoded in the DATABASE_URL format.

### 🔧 **URL Encoded Characters:**
- `@` becomes `%40`
- `#` becomes `%23`

### ✅ **Correct DATABASE_URL for Back4App:**

```
DATABASE_URL=postgresql://postgres.roffsfiooiutnghkyzzf:123456789%40abc%23@db.roffsfiooiutnghkyzzf.supabase.co:5432/postgres?sslmode=require
```

### 📋 **Back4App Setup Instructions:**

1. **Go to Back4App Dashboard → Your App → Server Settings → Environment Variables**

2. **Remove all individual DB variables:**
   - Delete: `DB_HOST`
   - Delete: `DB_PORT` 
   - Delete: `DB_NAME`
   - Delete: `DB_USER`
   - Delete: `DB_PASSWORD`

3. **Add ONE new variable:**
   - **Key:** `DATABASE_URL`
   - **Value:** `postgresql://postgres.roffsfiooiutnghkyzzf:123456789%40abc%23@db.roffsfiooiutnghkyzzf.supabase.co:5432/postgres?sslmode=require`

4. **Save and Re-deploy**

### 🚀 **Expected Success Logs:**
After re-deployment, you should see:
```
Using DATABASE_URL format: jdbc:postgresql://db.roffsfiooiutnghkyzzf.supabase.co:5432/postgres?sslmode=require
HikariPool-1 - Starting...
HikariPool-1 - Start completed.
Started AuthQuizApplication in X.XXX seconds
```

### 🔄 **Alternative (If URL encoding doesn't work):**
Keep individual variables but update the password:
```
DB_HOST=db.roffsfiooiutnghkyzzf.supabase.co
DB_PORT=5432
DB_NAME=postgres
DB_USER=postgres.roffsfiooiutnghkyzzf
DB_PASSWORD=123456789@abc#
```

The DATABASE_URL format is preferred, but if it doesn't work due to encoding issues, the individual variables should work with the enhanced SSL configuration I added.

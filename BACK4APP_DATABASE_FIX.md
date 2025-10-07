# Back4App Database Configuration Guide

## Issue Resolved: DATABASE_URL Environment Variable Problem

### Problem
The Spring Boot application was failing with:
```
Driver org.postgresql.Driver claims to not accept jdbcUrl, ${DATABASE_URL}
```

This occurred because Back4App wasn't providing the `DATABASE_URL` environment variable, or it wasn't in the expected format.

### Solution Applied

1. **Updated Database Configuration**: Modified `application-back4app.properties` to use individual database environment variables instead of relying solely on `DATABASE_URL`.

2. **Created Flexible Database Config**: Added `Back4AppDatabaseConfig.java` that can handle both:
   - `DATABASE_URL` format: `postgres://username:password@host:port/database`
   - Individual environment variables: `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`

### Back4App Environment Variables Setup

You need to set these environment variables in your Back4App dashboard:

#### Method 1: Individual Database Variables (Recommended)
```
DB_HOST=your-postgres-host
DB_PORT=5432
DB_NAME=your-database-name
DB_USER=your-username
DB_PASSWORD=your-password
```

#### Method 2: Complete Database URL
```
DATABASE_URL=postgres://username:password@host:port/database
```

### How to Set Environment Variables in Back4App

1. Go to your Back4App dashboard
2. Select your application
3. Go to "Server Settings" → "Environment Variables"
4. Add the database variables:

**For PostgreSQL (if you have a separate PostgreSQL service):**
```
DB_HOST=your-postgres-host.back4app.com
DB_PORT=5432
DB_NAME=your_database_name
DB_USER=your_username
DB_PASSWORD=your_secure_password
```

**For Back4App's built-in database:**
- Back4App primarily uses Parse Server with MongoDB
- If you need PostgreSQL, you might need to use an external service like:
  - ElephantSQL (free tier available)
  - Heroku Postgres (free tier available)
  - Supabase (free tier available)

### Alternative: Using External PostgreSQL Services

#### Option 1: ElephantSQL (Free)
1. Sign up at https://www.elephantsql.com/
2. Create a free "Tiny Turtle" instance
3. Get connection details and set in Back4App:
```
DB_HOST=your-server.db.elephantsql.com
DB_PORT=5432
DB_NAME=your-instance-name
DB_USER=your-instance-name
DB_PASSWORD=your-password
```

#### Option 2: Supabase (Free)
1. Sign up at https://supabase.com/
2. Create a new project
3. Get connection details from Settings → Database
4. Set in Back4App:
```
DB_HOST=db.your-project-ref.supabase.co
DB_PORT=5432
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=your-password
```

### Next Steps

1. **Set up database**: Choose one of the options above and set the environment variables in Back4App
2. **Re-deploy**: Trigger a new deployment in Back4App dashboard
3. **Check logs**: Monitor the deployment logs to ensure database connection succeeds
4. **Test endpoints**: Verify the application can connect to the database

### Troubleshooting

If you still see database connection issues:

1. **Check environment variables**: Ensure all required variables are set in Back4App dashboard
2. **Verify database access**: Make sure your database allows connections from Back4App's IP ranges
3. **Test connection**: Use a database client to verify the connection details work
4. **Check logs**: Look for specific error messages in Back4App deployment logs

### Current Application Status

✅ **RESOLVED**: JAR manifest error - Application starts successfully
✅ **RESOLVED**: Database configuration - Flexible handling of environment variables
⏳ **PENDING**: Database environment variables setup in Back4App dashboard

The application is now ready for successful deployment once the database environment variables are configured!

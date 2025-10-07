#!/bin/bash
# Quick Docker Setup Script for Quiz Application

echo "🐳 Starting Quiz Application with Docker..."
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose not found. Please install Docker Desktop."
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Stop any existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start all services
echo "🚀 Building and starting all services..."
docker-compose up --build -d

echo ""
echo "⏳ Waiting for services to start..."
sleep 10

# Check service health
echo ""
echo "🔍 Checking service status..."

# Check database
if docker exec quiz-postgres pg_isready -U postgres > /dev/null 2>&1; then
    echo "✅ Database: Running"
else
    echo "❌ Database: Not ready"
fi

# Check services
for service in auth-service question-service result-service; do
    if docker ps --format "table {{.Names}}\t{{.Status}}" | grep "quiz-$service" | grep -q "Up"; then
        echo "✅ $service: Running"
    else
        echo "❌ $service: Not running"
    fi
done

echo ""
echo "🌐 Your Quiz Application is ready!"
echo ""
echo "📱 Frontend:        http://localhost:3000"
echo "🔐 Auth Service:    http://localhost:8080"
echo "📝 Question Service: http://localhost:8081" 
echo "📊 Result Service:  http://localhost:8082"
echo "🗄️ Database:        localhost:5432"
echo ""
echo "💡 Commands:"
echo "   View logs:       docker-compose logs -f"
echo "   Stop services:   docker-compose down"
echo "   Restart:         docker-compose restart"
echo ""

# Open browser (optional)
read -p "🌐 Open application in browser? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v cmd.exe &> /dev/null; then
        # Windows
        cmd.exe /c start http://localhost:3000
    elif command -v open &> /dev/null; then
        # macOS
        open http://localhost:3000
    elif command -v xdg-open &> /dev/null; then
        # Linux
        xdg-open http://localhost:3000
    fi
fi

echo "🎉 Setup complete!"

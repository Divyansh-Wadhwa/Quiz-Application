// Centralized API configuration for all services
// Automatically detects environment and uses appropriate URLs

const isDevelopment = window.location.hostname === 'localhost' || 
                     window.location.hostname === '127.0.0.1' ||
                     window.location.port !== '';

let AUTH_API_BASE, QUESTION_API_BASE, RESULT_API_BASE;

if (isDevelopment) {
    // Local development URLs
    const API_HOST = window.API_HOST || 'localhost';
    AUTH_API_BASE = `http://${API_HOST}:8080/api/auth`;
    QUESTION_API_BASE = `http://${API_HOST}:8081/api/questions`;
    RESULT_API_BASE = `http://${API_HOST}:8082/api/results`;
    console.log('🔧 Running in DEVELOPMENT mode');
} else {
    // Production URLs - These will be automatically updated during deployment
    AUTH_API_BASE = window.PRODUCTION_AUTH_API || 'https://quiz-auth-production.up.railway.app/api/auth';
    QUESTION_API_BASE = window.PRODUCTION_QUESTION_API || 'https://quiz-questions-production.up.railway.app/api/questions';
    RESULT_API_BASE = window.PRODUCTION_RESULT_API || 'https://quiz-results-production.up.railway.app/api/results';
    console.log('🚀 Running in PRODUCTION mode');
    console.log('Auth API:', AUTH_API_BASE);
    console.log('Question API:', QUESTION_API_BASE);
    console.log('Result API:', RESULT_API_BASE);
}

// Optionally, expose these globally for all scripts
window.AUTH_API_BASE = AUTH_API_BASE;
window.QUESTION_API_BASE = QUESTION_API_BASE;
window.RESULT_API_BASE = RESULT_API_BASE;

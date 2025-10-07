// Production Configuration for Quiz Application
// Update these URLs with your actual Railway deployment URLs

window.PRODUCTION_AUTH_API = 'https://your-auth-service.railway.app/api/auth';
window.PRODUCTION_QUESTION_API = 'https://your-question-service.railway.app/api/questions';  
window.PRODUCTION_RESULT_API = 'https://your-result-service.railway.app/api/results';

console.log('Production configuration loaded');
console.log('Auth API:', window.PRODUCTION_AUTH_API);
console.log('Question API:', window.PRODUCTION_QUESTION_API);
console.log('Result API:', window.PRODUCTION_RESULT_API);

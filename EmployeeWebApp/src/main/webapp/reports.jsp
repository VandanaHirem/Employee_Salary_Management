<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Reports</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

* { 
    margin: 0; 
    padding: 0; 
    box-sizing: border-box; 
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 30px 20px;
    color: #1a202c;
}

.main-container {
    width: 100%;
    max-width: 700px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    color: #1a202c;
    padding: 40px 35px;
    border-radius: 24px;
    text-align: center;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.header h1 {
    font-size: 2.5rem;
    font-weight: 800;
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 20px;
    letter-spacing: -0.5px;
}

.reports-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    padding: 45px 40px;
    border-radius: 24px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

h2 {
    color: #1a202c;
    margin-bottom: 35px;
    text-align: center;
    font-size: 1.8rem;
    font-weight: 700;
    letter-spacing: -0.3px;
}

.report-link {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: white;
    text-decoration: none;
    padding: 22px 28px;
    margin-bottom: 20px;
    border-radius: 16px;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    font-weight: 600;
    font-size: 16px;
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
    position: relative;
    overflow: hidden;
}

.report-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.6s ease;
}

.report-link:hover::before {
    left: 100%;
}

.report-link:hover {
    background: linear-gradient(135deg, #5b59f1 0%, #7c3aed 100%);
    transform: translateY(-3px) scale(1.02);
    box-shadow: 0 15px 40px rgba(99, 102, 241, 0.4);
}

.report-link:active {
    transform: translateY(-1px) scale(1.01);
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
}

.report-link:last-child {
    margin-bottom: 0;
}

.report-text {
    flex: 1;
}

.report-icon {
    font-size: 24px;
    font-weight: 700;
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.report-link:hover .report-icon {
    transform: translateX(5px);
}

.back-link {
    display: inline-flex;
    align-items: center;
    gap: 12px;
    color: #6366f1;
    text-decoration: none;
    background: rgba(255, 255, 255, 0.9);
    padding: 15px 25px;
    border-radius: 16px;
    margin-top: 25px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-weight: 600;
    font-size: 15px;
    border: 2px solid rgba(99, 102, 241, 0.2);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.back-link:hover {
    background: rgba(255, 255, 255, 1);
    transform: translateX(-5px);
    color: #5b59f1;
    border-color: rgba(99, 102, 241, 0.3);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.back-arrow {
    font-size: 18px;
    font-weight: 700;
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.back-link:hover .back-arrow {
    transform: translateX(-3px);
}

.info-card {
    background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
    border: 2px solid rgba(14, 165, 233, 0.3);
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
}

.info-card h4 {
    color: #0c4a6e;
    margin-bottom: 15px;
    font-size: 18px;
    font-weight: 700;
}

.info-card p {
    color: #075985;
    font-size: 15px;
    line-height: 1.8;
    font-weight: 500;
}

/* Feature Icons */
.report-link:nth-child(1) .report-icon::before {
    content: "🔤";
}

.report-link:nth-child(2) .report-icon::before {
    content: "⏰";
}

.report-link:nth-child(3) .report-icon::before {
    content: "💰";
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 20px 15px;
    }
    
    .main-container {
        max-width: 100%;
        gap: 25px;
    }
    
    .header {
        padding: 30px 25px;
    }
    
    .header h1 {
        font-size: 2rem;
    }
    
    .reports-section {
        padding: 35px 25px;
    }
    
    .report-link {
        padding: 18px 22px;
        font-size: 15px;
        margin-bottom: 15px;
    }
    
    .info-card {
        padding: 25px 20px;
    }
}

@media (max-width: 480px) {
    .header h1 {
        font-size: 1.7rem;
    }
    
    h2 {
        font-size: 1.5rem;
    }
    
    .report-link {
        padding: 16px 20px;
        font-size: 14px;
        flex-direction: column;
        text-align: center;
        gap: 10px;
    }
    
    .report-icon {
        font-size: 20px;
    }
    
    .info-card p {
        font-size: 14px;
    }
}

/* Custom animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.header, .reports-section, .info-card {
    animation: fadeInUp 0.8s ease-out;
}

.reports-section {
    animation-delay: 0.2s;
}

.info-card {
    animation-delay: 0.4s;
}

/* Hover glow effect */
.report-link::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    border-radius: 16px;
    opacity: 0;
    transition: opacity 0.3s ease;
    pointer-events: none;
    box-shadow: 0 0 20px rgba(99, 102, 241, 0.6);
}

.report-link:hover::after {
    opacity: 1;
}
</style>
</head>
<body>
<div class="header">
    <h1>Employee Reports</h1>
    <a href="index.jsp" class="back-link">
        <span class="back-arrow">←</span>
        <span>Back to Home</span>
    </a>
</div>

<div class="main-container">
    <div class="reports-section">
        <h2>Available Reports</h2>

        <a href="report_form.jsp?action=NameFilter" class="report-link">
            <span class="report-text">Employees with Name Starting with Letter</span>
            <span class="report-icon">→</span>
        </a>

        <a href="report_form.jsp?action=ServiceFilter" class="report-link">
            <span class="report-text">Employees with N or More Years of Service</span>
            <span class="report-icon">→</span>
        </a>

        <a href="report_form.jsp?action=SalaryFilter" class="report-link">
            <span class="report-text">Employees with Salary Greater Than</span>
            <span class="report-icon">→</span>
        </a>
    </div>

    <div class="info-card">
        <h4>Report Information</h4>
        <p>• Generate filtered employee reports<br>
        • Filter by name, service years, or salary<br>
        • Export-ready report formats<br>
        • Real-time data from database</p>
    </div>
</div>
</body>
</html>
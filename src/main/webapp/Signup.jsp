<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up - Library management system</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #8B0000;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            
            .signup-container {
                background-color: #f0f0f0;
                border: none;
                border-radius: 15px;
                padding: 30px 40px;
                width: 100%;
                max-width: 95%;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                margin: 10px auto;
            }
            
            .signup-header {
                margin-bottom: 25px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 20px;
            }
            
            .signup-header h1 {
                font-size: 26px;
                color: black;
                font-weight: bold;
                margin-bottom: 10px;
                letter-spacing: 0.3px;
            }
            
            .signup-header h2 {
                font-size: 32px;
                color: #cc0000;
                font-weight: 400;
                letter-spacing: 1px;
            }
            
            .form-group {
                margin-bottom: 18px;
                display: flex;
                align-items: center;
            }
            
            .form-group label {
                color: black;
                font-size: 15px;
                width: 140px;
                text-align: left;
                margin-right: 15px;
                font-weight: 400;
                flex-shrink: 0;
            }
            
            .form-group input {
                flex: 1;
                padding: 12px 14px;
                border: 1px solid black;
                background-color: white;
                font-size: 15px;
                min-width: 0;
                transition: all 0.2s ease;
                border-radius: 5px;
            }
            
            .form-group input:focus {
                outline: 2px solid #333;
                outline-offset: -1px;
                background-color: #fafafa;
            }
            
            .form-section {
                margin-bottom: 25px;
                padding-bottom: 20px;
                border-bottom: 1px solid #ddd;
            }
            
            .form-section:last-child {
                border-bottom: none;
            }
            
            .form-section-title {
                font-size: 17px;
                font-weight: bold;
                color: #333;
                margin-bottom: 18px;
            }
            
            .form-sections-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px;
            }
            
            @media (max-width: 1200px) {
                .form-sections-container {
                    grid-template-columns: 1fr;
                }
            }
            
            .signup-button-container {
                text-align: center;
                margin-top: 30px;
                padding-top: 20px;
            }
            
            .signup-button {
                background-color: #cc0000;
                color: white;
                border: 1px solid black;
                padding: 14px 60px;
                font-size: 17px;
                cursor: pointer;
                font-weight: 400;
                transition: all 0.2s ease;
                min-width: 140px;
                letter-spacing: 0.5px;
                border-radius: 5px;
            }
            
            .signup-button:hover {
                background-color: #990000;
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }
            
            .signup-button:active {
                background-color: #770000;
                transform: translateY(0);
            }
            
            .error-message {
                background-color: #fee;
                color: #c33;
                padding: 14px;
                margin-bottom: 20px;
                border: 1px solid #fcc;
                font-size: 14px;
                text-align: center;
                border-radius: 5px;
            }
            
            .success-message {
                background-color: #efe;
                color: #3c3;
                padding: 14px;
                margin-bottom: 20px;
                border: 1px solid #cfc;
                font-size: 14px;
                text-align: center;
                border-radius: 5px;
            }
            
            .back-link {
                text-align: center;
                margin-top: 20px;
            }
            
            .back-link a {
                color: #8B0000;
                text-decoration: none;
                font-size: 14px;
            }
            
            .back-link a:hover {
                text-decoration: underline;
            }
            
            .form-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
            
            @media (max-width: 1200px) {
                .form-container {
                    grid-template-columns: 1fr;
                }
            }
            
            @media (max-width: 700px) {
                .signup-container {
                    padding: 20px 25px;
                }
                
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }
                
                .form-group label {
                    width: 100%;
                    margin-bottom: 8px;
                    margin-right: 0;
                }
                
                .form-group input {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="signup-container">
            <div class="signup-header">
                <h1>Library management system</h1>
                <h2>Sign Up</h2>
            </div>
            
            <% 
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
            %>
            
            <% if (error != null) { %>
                <div class="error-message">
                    <%= error %>
                </div>
            <% } %>
            
            <% if (message != null) { %>
                <div class="success-message">
                    <%= message %>
                </div>
            <% } %>
            
            <% if (message == null) { %>
            <form action="SignupController" method="POST">
                <div class="form-sections-container">
                    <div class="form-section">
                        <div class="form-section-title">Account Information</div>
                        <div class="form-group">
                            <label for="txtUsername">Username:</label>
                            <input type="text" id="txtUsername" name="txtUsername" required autofocus>
                        </div>
                        
                        <div class="form-group">
                            <label for="txtPassword">Password:</label>
                            <input type="password" id="txtPassword" name="txtPassword" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="txtEmail">Email:</label>
                            <input type="email" id="txtEmail" name="txtEmail" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="txtPhone">Phone:</label>
                            <input type="tel" id="txtPhone" name="txtPhone" required>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <div class="form-section-title">Full Name</div>
                        <div class="form-group">
                            <label for="txtFirstname">First name:</label>
                            <input type="text" id="txtFirstname" name="txtFirstname" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="txtMiddlename">Middle name:</label>
                            <input type="text" id="txtMiddlename" name="txtMiddlename">
                        </div>
                        
                        <div class="form-group">
                            <label for="txtLastname">Last name:</label>
                            <input type="text" id="txtLastname" name="txtLastname" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <div class="form-section-title">Address</div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="txtHomeNumber">Home Number:</label>
                            <input type="text" id="txtHomeNumber" name="txtHomeNumber" required>
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="txtBuilding">Building:</label>
                            <input type="text" id="txtBuilding" name="txtBuilding">
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="txtStreet">Street:</label>
                            <input type="text" id="txtStreet" name="txtStreet" required>
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="txtWard">Ward/Commune:</label>
                            <input type="text" id="txtWard" name="txtWard" required>
                        </div>
                    </div>
                </div>
                
                <div class="signup-button-container">
                    <button type="submit" class="signup-button">Sign Up</button>
                </div>
            </form>
            <% } %>
            
            <div class="back-link">
                <a href="Login.jsp">← Back to Login</a>
            </div>
        </div>
    </body>
</html>


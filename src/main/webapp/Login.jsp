<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - Library management system</title>
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
            
            .login-container {
                background-color: #f0f0f0;
                border: none;
                border-radius: 15px;
                padding: 50px 60px;
                width: 100%;
                max-width: 550px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .login-header {
                margin-bottom: 40px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 20px;
            }
            
            .login-header h1 {
                font-size: 26px;
                color: black;
                font-weight: bold;
                margin-bottom: 10px;
                letter-spacing: 0.3px;
            }
            
            .login-header h2 {
                font-size: 32px;
                color: #cc0000;
                font-weight: 400;
                letter-spacing: 1px;
            }
            
            .form-group {
                margin-bottom: 28px;
                display: flex;
                align-items: center;
            }
            
            .form-group label {
                color: black;
                font-size: 15px;
                width: 120px;
                text-align: left;
                margin-right: 20px;
                font-weight: 400;
                flex-shrink: 0;
            }
            
            .form-group input {
                flex: 1;
                padding: 12px 15px;
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
            
            .login-button-container {
                text-align: center;
                margin-top: 40px;
                padding-top: 20px;
            }
            
            .login-button {
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
            
            .login-button:hover {
                background-color: #990000;
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }
            
            .login-button:active {
                background-color: #770000;
                transform: translateY(0);
            }
            
            .error-message {
                background-color: #fee;
                color: #c33;
                padding: 14px;
                margin-bottom: 28px;
                border: 1px solid #fcc;
                font-size: 14px;
                text-align: center;
                border-radius: 5px;
            }
            
            @media (max-width: 600px) {
                .login-container {
                    padding: 40px 30px;
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
        <div class="login-container">
            <div class="login-header">
                <h1>Library management system</h1>
                <h2>Login</h2>
            </div>
            
            <% 
                String error = (String) request.getAttribute("error");
            %>
            
            <% if (error != null) { %>
                <div class="error-message">
                    <%= error %>
                </div>
            <% } %>
            
            <form action="LoginController" method="POST">
                <div class="form-group">
                    <label for="txtUsername">username:</label>
                    <input type="text" id="txtUsername" name="txtUsername" required autofocus>
                </div>
                
                <div class="form-group">
                    <label for="txtPassword">password:</label>
                    <input type="password" id="txtPassword" name="txtPassword" required>
                </div>
                
                <div class="login-button-container">
                    <button type="submit" class="login-button">Login</button>
                </div>
            </form>
            
            <div style="text-align: center; margin-top: 20px;">
                <a href="Signup.jsp" style="color: #8B0000; text-decoration: none; font-size: 14px;">Don't have an account? Sign up here</a>
            </div>
        </div>
    </body>
</html>

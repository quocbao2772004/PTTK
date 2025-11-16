<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Reader"%>
<%@page import="Model.Fullname"%>
<%
    // Kiểm tra session
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    Reader reader = (Reader) session.getAttribute("user");
    if (!"Reader".equals(reader.getRole())) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    Fullname fullname = reader.getFullname();
    String displayName = fullname != null ? 
        (fullname.getFirstname() + " " + (fullname.getMiddlename() != null ? fullname.getMiddlename() + " " : "") + fullname.getLastname()) 
        : reader.getUsername();
    String firstLetter = displayName.length() > 0 ? displayName.substring(0, 1).toUpperCase() : "L";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Library Management System - Reader</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: Arial, sans-serif;
                background-color: white;
            }
            
            .header {
                background-color: #8B0000;
                color: white;
                padding: 20px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            }
            
            .header-left {
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 1px;
            }
            
            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            
            .user-avatar {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background-color: #87CEEB;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }
            
            .logout-btn {
                background-color: rgba(255, 0, 0, 0.3);
                color: white;
                border: 1px solid rgba(255, 255, 255, 0.5);
                padding: 10px 25px;
                cursor: pointer;
                text-decoration: none;
                font-size: 15px;
                border-radius: 5px;
                transition: all 0.3s ease;
            }
            
            .logout-btn:hover {
                background-color: rgba(255, 0, 0, 0.5);
                border-color: white;
            }
            
            .main-container {
                display: flex;
                min-height: calc(100vh - 85px);
                border: 2px solid #8B0000;
            }
            
            .left-panel {
                width: 35%;
                background-color: white;
                border-right: 2px solid #8B0000;
                padding: 40px;
            }
            
            .right-panel {
                width: 65%;
                background-color: white;
                padding: 40px;
            }
            
            .avatar-large {
                width: 90px;
                height: 90px;
                border-radius: 50%;
                background-color: #87CEEB;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 36px;
                margin-bottom: 25px;
                box-shadow: 0 3px 6px rgba(0,0,0,0.15);
            }
            
            .user-name {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 8px;
                color: black;
            }
            
            .user-role {
                font-size: 18px;
                color: black;
                margin-bottom: 25px;
                font-weight: 500;
            }
            
            .divider {
                border-top: 2px solid #8B0000;
                margin: 25px 0;
            }
            
            .info-section {
                margin-bottom: 18px;
            }
            
            .info-label {
                font-weight: bold;
                color: black;
                margin-bottom: 8px;
                font-size: 15px;
            }
            
            .info-value {
                color: black;
                margin-left: 15px;
                font-size: 15px;
            }
            
            .account-info {
                margin-top: 18px;
            }
            
            .account-info .info-item {
                margin-bottom: 10px;
                color: black;
                font-size: 15px;
                padding-left: 5px;
            }
            
            .status-section {
                margin-top: 25px;
            }
            
            .status-section .info-label {
                font-size: 16px;
            }
            
            .reader-card-section {
                border: 2px solid #8B0000;
                padding: 30px;
                margin-top: 30px;
                border-radius: 8px;
            }
            
            .reader-card-title {
                font-size: 24px;
                font-weight: bold;
                color: black;
                margin-bottom: 25px;
            }
            
            .no-card-message {
                color: black;
                font-size: 18px;
                margin-bottom: 20px;
                font-weight: 500;
            }
            
            .register-link {
                color: purple;
                text-decoration: underline;
                font-size: 18px;
                cursor: pointer;
                display: inline-block;
                margin-left: 25px;
                transition: color 0.2s;
                font-weight: 500;
            }
            
            .register-link:hover {
                color: #6a0dad;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-left">Library Management System</div>
            <div class="header-right">
                <div class="user-avatar"><%= firstLetter %></div>
                <a href="LoginController" class="logout-btn">Logout</a>
            </div>
        </div>
        
        <div class="main-container">
            <div class="left-panel">
                <div class="avatar-large"><%= firstLetter %></div>
                <div class="user-name"><%= displayName %></div>
                <div class="user-role">USER</div>
                
                <div class="divider"></div>
                
                <div class="info-section">
                    <div class="info-label">Full name:</div>
                    <div class="info-value"><%= displayName %></div>
                </div>
                
                <div class="divider"></div>
                
                <div class="account-info">
                    <div class="info-label">Account Information:</div>
                    <div class="info-item">Username: <%= reader.getUsername() %></div>
                    <div class="info-item">Email: <%= reader.getEmail() %></div>
                    <div class="info-item">Role: User</div>
                </div>
                
                <div class="divider"></div>
                
                <div class="status-section">
                    <div class="info-label">Status: Active</div>
                </div>
            </div>
            
            <div class="right-panel">
                <div class="reader-card-section">
                    <div class="reader-card-title">Reader Card</div>
                    <div class="no-card-message">! You have not registered a reader card</div>
                    <a href="RegisterReaderCardUI.jsp" class="register-link">Register reader card</a>
                </div>
            </div>
        </div>
    </body>
</html>

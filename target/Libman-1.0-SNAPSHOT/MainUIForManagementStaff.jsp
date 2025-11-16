<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.ManagementStaff"%>
<%@page import="Model.Fullname"%>
<%
    // Kiểm tra session
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    ManagementStaff staff = (ManagementStaff) session.getAttribute("user");
    if (!"ManagementStaff".equals(staff.getRole())) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    Fullname fullname = staff.getFullname();
    String displayName = fullname != null ? 
        (fullname.getFirstname() + " " + (fullname.getMiddlename() != null ? fullname.getMiddlename() + " " : "") + fullname.getLastname()) 
        : staff.getUsername();
    String firstLetter = displayName.length() > 0 ? displayName.substring(0, 1).toUpperCase() : "M";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Library Management System - Management</title>
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
                background-color: red;
                color: white;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .header-left {
                font-size: 18px;
                font-weight: bold;
            }
            
            .header-right {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            
            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #87CEEB;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 18px;
            }
            
            .logout-btn {
                background-color: red;
                color: white;
                border: 1px solid white;
                padding: 8px 20px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
            }
            
            .logout-btn:hover {
                background-color: #cc0000;
            }
            
            .main-container {
                display: flex;
                min-height: calc(100vh - 70px);
                border: 2px solid red;
            }
            
            .left-sidebar {
                width: 30%;
                background-color: white;
                border-right: 2px solid red;
                padding: 30px;
            }
            
            .right-content {
                width: 70%;
                background-color: white;
                padding: 30px;
            }
            
            .avatar-large {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background-color: #87CEEB;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 32px;
                margin-bottom: 20px;
            }
            
            .user-name {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 5px;
                color: black;
            }
            
            .user-role {
                font-size: 16px;
                color: black;
                margin-bottom: 20px;
            }
            
            .divider {
                border-top: 2px solid red;
                margin: 20px 0;
            }
            
            .info-section {
                margin-bottom: 15px;
            }
            
            .info-label {
                font-weight: bold;
                color: black;
                margin-bottom: 5px;
            }
            
            .info-value {
                color: black;
                margin-left: 10px;
            }
            
            .account-info {
                margin-top: 15px;
            }
            
            .account-info .info-item {
                margin-bottom: 8px;
                color: black;
            }
            
            .status-section {
                margin-top: 20px;
            }
            
            .statistics-title {
                font-size: 24px;
                font-weight: bold;
                color: black;
                margin-bottom: 30px;
            }
            
            .statistics-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
            }
            
            .stat-card {
                border: 2px solid red;
                padding: 20px;
            }
            
            .stat-title {
                font-size: 16px;
                font-weight: bold;
                color: red;
                margin-bottom: 15px;
            }
            
            .stat-button {
                background-color: white;
                color: black;
                border: 1px solid black;
                padding: 10px 15px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
            }
            
            .stat-button:hover {
                background-color: #f0f0f0;
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
            <div class="left-sidebar">
                <div class="avatar-large"><%= firstLetter %></div>
                <div class="user-name"><%= displayName %></div>
                <div class="user-role">ADMIN</div>
                
                <div class="divider"></div>
                
                <div class="info-section">
                    <div class="info-label">Full name:</div>
                    <div class="info-value"><%= displayName %></div>
                </div>
                
                <div class="divider"></div>
                
                <div class="account-info">
                    <div class="info-label">Account Information:</div>
                    <div class="info-item">Username: <%= staff.getUsername() %></div>
                    <div class="info-item">Email: <%= staff.getEmail() %></div>
                    <div class="info-item">Role: Admin</div>
                </div>
                
                <div class="divider"></div>
                
                <div class="status-section">
                    <div class="info-label">Status: Active</div>
                </div>
            </div>
            
            <div class="right-content">
                <div class="statistics-title">View Statistics</div>
                
                <div class="statistics-grid">
                    <div class="stat-card">
                        <div class="stat-title">Reader statistics by number of loans</div>
                        <a href="#" class="stat-button">Open reader statistic</a>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-title">Supplier statistic by Imported volume</div>
                        <a href="StatSuppliersUI.jsp" class="stat-button">Open supplier statistic</a>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-title">Statistics of documents by number of loans</div>
                        <a href="#" class="stat-button">Open document statistic</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

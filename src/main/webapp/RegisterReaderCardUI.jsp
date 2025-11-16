<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Reader"%>
<%@page import="Model.Fullname"%>
<%@page import="Model.Address"%>
<%
    // Kiểm tra session - chỉ Reader mới được truy cập
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
    Address address = reader.getAddress();
    
    String firstname = fullname != null ? fullname.getFirstname() : "";
    String middlename = fullname != null ? fullname.getMiddlename() : "";
    String lastname = fullname != null ? fullname.getLastname() : "";
    String email = reader.getEmail() != null ? reader.getEmail() : "";
    String phone = reader.getPhonenumber() != null ? reader.getPhonenumber() : "";
    String homeNumber = address != null ? address.getHomenumber() : "";
    String building = address != null ? address.getBuilding() : "";
    String street = address != null ? address.getStreet() : "";
    String ward = address != null ? address.getWardcommune() : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Reader Card</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: Arial, sans-serif;
                background-color: #8B0000;
            }
            
            .container {
                border: 3px solid #8B0000;
                border-bottom: 1px solid #8B0000;
                margin: 10px;
                padding: 25px;
                background-color: white;
                max-width: 98%;
                margin-left: auto;
                margin-right: auto;
            }
            
            .back-link {
                color: #8B0000;
                text-decoration: none;
                font-size: 18px;
                margin-bottom: 15px;
                display: inline-block;
            }
            
            .back-link:hover {
                text-decoration: underline;
            }
            
            .title {
                font-size: 28px;
                font-weight: bold;
                color: black;
                margin-bottom: 18px;
                text-align: center;
            }
            
            .card-code-container {
                background-color: #f0f0f0;
                padding: 15px;
                margin-bottom: 20px;
                text-align: center;
                border-radius: 5px;
            }
            
            .card-code-display {
                font-size: 20px;
                font-weight: bold;
                color: black;
            }
            
            .form-table {
                width: 100%;
                margin: 0 auto;
                border-collapse: collapse;
                border: 1px solid black;
                font-size: 16px;
            }
            
            .form-table td {
                padding: 12px;
                border: 1px solid black;
            }
            
            .form-table td:first-child {
                width: 220px;
                background-color: #f9f9f9;
                font-weight: bold;
            }
            
            .form-table input[type="text"],
            .form-table input[type="email"],
            .form-table input[type="tel"],
            .form-table input[type="date"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                font-size: 16px;
            }
            
            .form-table input[type="text"]:focus,
            .form-table input[type="email"]:focus,
            .form-table input[type="tel"]:focus,
            .form-table input[type="date"]:focus {
                outline: 2px solid #8B0000;
                outline-offset: -1px;
            }
            
            .button-container {
                margin-top: 20px;
                display: flex;
                gap: 15px;
                justify-content: center;
                align-items: center;
            }
            
            .btn-red {
                background-color: #8B0000;
                color: white;
                border: 1px solid black;
                padding: 12px 35px;
                font-size: 18px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                border-radius: 5px;
            }
            
            .btn-red:hover {
                background-color: #6B0000;
            }
            
            .message {
                padding: 30px;
                margin: 20px 0;
                border-radius: 10px;
                text-align: center;
                font-size: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border: 2px solid #28a745;
            }
            
            .success-icon {
                font-size: 56px;
                margin-bottom: 15px;
            }
            
            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            
            #imageFileName {
                font-size: 16px;
            }
        </style>
        <script>
            function generateCardCode() {
                const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                let code = '';
                for (let i = 0; i < 4; i++) {
                    if (i > 0) code += '-';
                    for (let j = 0; j < 4; j++) {
                        code += chars.charAt(Math.floor(Math.random() * chars.length));
                    }
                }
                document.getElementById('txtCardCode').value = code;
                // Hiển thị mã thẻ
                document.getElementById('cardCodeDisplay').textContent = code;
            }
            
            window.onload = function() {
                generateCardCode();
            };
        </script>
    </head>
    <body>
        <div class="container">
            <a href="MainUI.jsp" class="back-link">&lt;- Back to home</a>
            
            <div class="title">Register Reader Card</div>
            
            <% 
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
            %>
            
            <% if (message != null) { %>
                <div class="message success">
                    <div class="success-icon">✓</div>
                    <div style="font-weight: bold; margin-bottom: 10px;"><%= message %></div>
                    <a href="MainUI.jsp" class="back-link" style="margin-top: 20px; display: inline-block;">&lt;- Back to home</a>
                </div>
            <% } else if (error != null) { %>
                <div class="message error"><%= error %></div>
            <% } else { %>
            
            <div class="card-code-container">
                <div class="card-code-display">Card code: <span id="cardCodeDisplay"></span></div>
            </div>
            
            <form action="ReaderCardController" method="POST" enctype="multipart/form-data" id="registerForm">
                <input type="hidden" id="txtCardCode" name="txtCardCode" value="">
                
                <table class="form-table">
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="txtUsername" value="<%= reader.getUsername() %>" required></td>
                    </tr>
                    <tr>
                        <td>First name:</td>
                        <td><input type="text" name="txtFirstname" value="<%= firstname %>" required></td>
                    </tr>
                    <tr>
                        <td>Middle name:</td>
                        <td><input type="text" name="txtMiddlename" value="<%= middlename %>"></td>
                    </tr>
                    <tr>
                        <td>Last name:</td>
                        <td><input type="text" name="txtLastname" value="<%= lastname %>" required></td>
                    </tr>
                    <tr>
                        <td>Date of birth:</td>
                        <td><input type="date" name="txtDOB" required></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><input type="email" name="txtEmail" value="<%= email %>" required></td>
                    </tr>
                    <tr>
                        <td>Phone:</td>
                        <td><input type="tel" name="txtPhone" value="<%= phone %>" required></td>
                    </tr>
                    <tr>
                        <td>Home Number:</td>
                        <td><input type="text" name="txtHomeNumber" value="<%= homeNumber %>" required></td>
                    </tr>
                    <tr>
                        <td>Building:</td>
                        <td><input type="text" name="txtBuilding" value="<%= building %>"></td>
                    </tr>
                    <tr>
                        <td>Street:</td>
                        <td><input type="text" name="txtStreet" value="<%= street %>" required></td>
                    </tr>
                    <tr>
                        <td>Ward/Commune:</td>
                        <td><input type="text" name="txtWard" value="<%= ward %>" required></td>
                    </tr>
                </table>
                
                <div class="button-container">
                    <button type="button" class="btn-red" onclick="document.getElementById('imageInput').click()">Upload image</button>
                    <input type="file" id="imageInput" name="imageuser" accept="image/*" style="display: none;" onchange="document.getElementById('imageFileName').textContent = this.files[0] ? this.files[0].name : 'No file selected'">
                    <span id="imageFileName" style="margin-left: 10px; color: #666;"></span>
                </div>
                
                <div class="button-container">
                    <button type="submit" class="btn-red" name="btnCreateCard">Create a reader card</button>
                </div>
            </form>
            
            <script>
                // Cập nhật khi mã thẻ thay đổi (nếu có)
                document.getElementById('txtCardCode').addEventListener('input', function() {
                    document.getElementById('cardCodeDisplay').textContent = this.value;
                });
            </script>
            
            <% } %>
        </div>
    </body>
</html>

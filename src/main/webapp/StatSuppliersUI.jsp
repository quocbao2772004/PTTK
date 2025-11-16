<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.StatSuppliers"%>
<%@page import="Model.ManagementStaff"%>
<%@page import="Model.Fullname"%>
<%@page import="java.util.List"%>
<%
    // Kiểm tra session - chỉ ManagementStaff mới được truy cập
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Management Dashboard</title>
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
            
            .main-container {
                border: 3px solid #8B0000;
                margin: 20px;
                padding: 0;
                background-color: white;
            }
            
            .header {
                padding: 20px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }
            
            .header-left {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            
            .back-btn {
                background-color: #8B0000;
                color: white;
                border: 1px solid black;
                padding: 10px 20px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
                border-radius: 5px;
            }
            
            .back-btn:hover {
                background-color: #6B0000;
            }
            
            .header-center {
                flex: 1;
                text-align: center;
            }
            
            .header-center h1 {
                font-size: 24px;
                font-weight: bold;
                color: black;
                margin-bottom: 5px;
            }
            
            .header-center .welcome-text {
                font-size: 14px;
                color: black;
            }
            
            .header-right {
                display: flex;
                align-items: center;
            }
            
            .logout-btn {
                background-color: #8B0000;
                color: white;
                border: 1px solid black;
                padding: 10px 20px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
                border-radius: 5px;
            }
            
            .logout-btn:hover {
                background-color: #6B0000;
            }
            
            .divider {
                height: 2px;
                background-color: #8B0000;
                margin: 0;
            }
            
            .content {
                padding: 30px;
            }
            
            .report-section {
                text-align: center;
                margin-bottom: 25px;
            }
            
            .report-title {
                font-size: 20px;
                font-weight: bold;
                color: #8B0000;
                margin-bottom: 20px;
            }
            
            .filter-section {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 15px;
                margin-bottom: 25px;
                flex-wrap: wrap;
            }
            
            .filter-section label {
                font-size: 14px;
                color: black;
                font-weight: normal;
            }
            
            .filter-section input[type="date"] {
                padding: 8px 12px;
                border: 1px solid black;
                font-size: 14px;
                border-radius: 3px;
            }
            
            .view-stat-btn {
                background-color: #8B0000;
                color: white;
                border: 1px solid black;
                padding: 10px 25px;
                cursor: pointer;
                font-size: 14px;
                border-radius: 5px;
            }
            
            .view-stat-btn:hover {
                background-color: #6B0000;
            }
            
            .table-container {
                margin-top: 20px;
            }
            
            .stat-table {
                width: 100%;
                border-collapse: collapse;
                border: 1px solid black;
            }
            
            .stat-table thead tr {
                background-color: #8B0000;
                color: white;
            }
            
            .stat-table th {
                padding: 12px;
                text-align: left;
                border: 1px solid black;
                font-weight: bold;
                font-size: 14px;
            }
            
            .stat-table td {
                padding: 12px;
                text-align: left;
                border: 1px solid black;
                background-color: white;
                font-size: 14px;
            }
            
            .stat-table tbody tr {
                cursor: pointer;
            }
            
            .stat-table tbody tr:hover {
                background-color: #ffe6e6;
            }
            
            .stat-table tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            
            .stat-table tbody tr:nth-child(even):hover {
                background-color: #ffe6e6;
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
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="header">
                <div class="header-left">
                    <a href="MainUI.jsp" class="back-btn">Back to menu</a>
                </div>
                <div class="header-center">
                    <h1>Management Dashboard</h1>
                    <div class="welcome-text">Welcome, <%= displayName %></div>
                    <div class="welcome-text">Role: Management staff</div>
                </div>
                <div class="header-right">
                    <a href="LoginController" class="logout-btn">Logout</a>
                </div>
            </div>
            
            <div class="divider"></div>
            
            <div class="content">
                <div class="report-section">
                    <div class="report-title">Statistic report by imported volume</div>
                    
                    <% 
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                        <div class="error-message"><%= error %></div>
                    <% } %>
                    
                    <form action="StatSupplierController" method="GET">
                        <div class="filter-section">
                            <label>From:</label>
                            <input type="date" name="txtStartDate" id="txtStartDate" required>
                            <label>to:</label>
                            <input type="date" name="txtEndDate" id="txtEndDate" required>
                            <button type="submit" class="view-stat-btn">View statistic</button>
                        </div>
                    </form>
                </div>
                
                <% 
                    List<StatSuppliers> listSupplier = (List<StatSuppliers>) request.getAttribute("listSupplier");
                    String startDate = request.getParameter("txtStartDate");
                    String endDate = request.getParameter("txtEndDate");
                %>
                
                <% if (listSupplier != null && !listSupplier.isEmpty()) { %>
                    <div class="table-container">
                        <table class="stat-table">
                            <thead>
                                <tr>
                                    <th>Supplier ID</th>
                                    <th>Supplier name</th>
                                    <th>Number of import times</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (StatSuppliers stat : listSupplier) { %>
                                    <tr onclick="window.location.href='ImportedInvoiceController?action=list&supplierId=<%= stat.getSupplier().getId() %>&startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>'">
                                        <td><%= stat.getSupplier().getId() %></td>
                                        <td><%= stat.getSupplier().getSupplierName() %></td>
                                        <td><%= stat.getImportQuantity() %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else if (listSupplier != null && listSupplier.isEmpty()) { %>
                    <div style="text-align: center; padding: 20px; color: #666;">
                        No data found for the selected date range.
                    </div>
                <% } %>
            </div>
        </div>
        
        <script>
            // Set default dates (current month)
            window.onload = function() {
                var today = new Date();
                var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                var lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                
                var startDateInput = document.getElementById('txtStartDate');
                var endDateInput = document.getElementById('txtEndDate');
                
                if (startDateInput && !startDateInput.value) {
                    startDateInput.value = firstDay.toISOString().split('T')[0];
                }
                if (endDateInput && !endDateInput.value) {
                    endDateInput.value = lastDay.toISOString().split('T')[0];
                }
            };
        </script>
    </body>
</html>

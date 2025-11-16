<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.ImportedInvoice"%>
<%@page import="Model.ManagementStaff"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    
    List<ImportedInvoice> listImportedInvoice = (List<ImportedInvoice>) request.getAttribute("listImportedInvoice");
    String startDate = (String) request.getAttribute("startDate");
    String endDate = (String) request.getAttribute("endDate");
    
    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    
    String displayStartDate = "";
    String displayEndDate = "";
    if (startDate != null && !startDate.isEmpty()) {
        try {
            displayStartDate = sdfDisplay.format(sdfInput.parse(startDate));
        } catch (Exception e) {
            displayStartDate = startDate;
        }
    }
    if (endDate != null && !endDate.isEmpty()) {
        try {
            displayEndDate = sdfDisplay.format(sdfInput.parse(endDate));
        } catch (Exception e) {
            displayEndDate = endDate;
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Statistic report by imported volume</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: Arial, sans-serif;
                background-color: white;
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }
            
            
            .report-title {
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                color: #8B0000;
                padding: 35px 20px;
                letter-spacing: 0.5px;
            }
            
            .date-range-bar {
                background-color: #ffcccc;
                padding: 18px 20px;
                text-align: center;
                color: #8B0000;
                font-size: 18px;
                font-weight: 500;
                letter-spacing: 0.3px;
            }
            
            .table-container {
                padding: 0;
                width: 100%;
            }
            
            .invoice-table {
                width: 100%;
                border-collapse: collapse;
                border: 1px solid black;
            }
            
            .invoice-table thead tr {
                background-color: #8B0000;
                color: white;
            }
            
            .invoice-table th {
                padding: 20px;
                text-align: left;
                border: 1px solid black;
                font-weight: bold;
                font-size: 18px;
                letter-spacing: 0.3px;
            }
            
            .invoice-table td {
                padding: 18px 20px;
                text-align: left;
                border: 1px solid black;
                background-color: white;
                font-size: 16px;
            }
            
            .invoice-table tbody tr {
                border-bottom: 1px solid black;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }
            
            .invoice-table tbody tr:hover {
                background-color: #ffe6e6;
            }
            
            .back-button-container {
                padding: 25px 30px;
                text-align: right;
                background-color: #fafafa;
                border-top: 1px solid #ddd;
                margin-top: auto;
            }
            
            .main-container {
                border: 3px solid #8B0000;
                width: 100%;
                min-height: 100vh;
                background-color: white;
                padding: 0;
                margin: 0;
                display: flex;
                flex-direction: column;
            }
            
            .back-btn {
                background-color: transparent;
                color: #8B0000;
                border: 2px solid #8B0000;
                padding: 12px 30px;
                cursor: pointer;
                text-decoration: none;
                font-size: 15px;
                display: inline-block;
                border-radius: 5px;
                transition: all 0.3s ease;
                font-weight: 500;
            }
            
            .back-btn:hover {
                background-color: #8B0000;
                color: white;
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="report-title">Statistic report by imported volume</div>
            
            <% if (displayStartDate != null && !displayStartDate.isEmpty() && displayEndDate != null && !displayEndDate.isEmpty()) { %>
                <div class="date-range-bar">
                    From <%= displayStartDate %> to <%= displayEndDate %>
                </div>
            <% } %>
            
            <div class="table-container">
                <% if (listImportedInvoice != null && !listImportedInvoice.isEmpty()) { %>
                    <table class="invoice-table">
                        <thead>
                            <tr>
                                <th>Imported ID</th>
                                <th>Imported date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (ImportedInvoice invoice : listImportedInvoice) { 
                                String invoiceCode = invoice.getImportedCode();
                                // Format code to INV001, INV002 format if it's numeric
                                if (invoiceCode != null && invoiceCode.matches("\\d+")) {
                                    invoiceCode = "INV" + String.format("%03d", Integer.parseInt(invoiceCode));
                                }
                            %>
                                <tr onclick="window.location.href='ImportedInvoiceController?action=detail&invoiceId=<%= invoice.getId() %>'">
                                    <td><%= invoiceCode != null ? invoiceCode : "" %></td>
                                    <td><%= sdfDisplay.format(invoice.getImportedDate()) %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <div style="padding: 40px; text-align: center; color: #666;">
                        No imported invoices found for the selected supplier and date range.
                    </div>
                <% } %>
            </div>
            
            <div class="back-button-container">
                <a href="StatSuppliersUI.jsp" class="back-btn">&lt;- Back to date selection</a>
            </div>
        </div>
    </body>
</html>

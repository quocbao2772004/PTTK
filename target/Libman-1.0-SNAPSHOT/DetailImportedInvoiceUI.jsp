<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.ImportedInvoice"%>
<%@page import="Model.ImportedInvoiceDetail"%>
<%@page import="Model.ManagementStaff"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    
    ImportedInvoice importedinvoice = (ImportedInvoice) request.getAttribute("importedinvoice");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Imported Invoice detail</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: Arial, sans-serif;
                background-color: white;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }
            
            .main-container {
                border: 3px solid #8B0000;
                width: 100%;
                max-width: 1400px;
                background-color: white;
                padding: 0;
            }
            
            .page-title {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                color: black;
                padding: 30px 20px;
                border-bottom: 1px solid #ddd;
            }
            
            .content-wrapper {
                display: flex;
                min-height: 600px;
            }
            
            .left-panel {
                flex: 1;
                padding: 30px;
                border-right: 1px solid #ddd;
                background-color: #fafafa;
            }
            
            .right-panel {
                flex: 1;
                padding: 30px;
                background-color: white;
            }
            
            .panel-title {
                font-size: 20px;
                font-weight: bold;
                color: #8B0000;
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 2px solid #8B0000;
            }
            
            .info-item {
                margin-bottom: 20px;
            }
            
            .info-label {
                font-weight: bold;
                color: black;
                margin-bottom: 5px;
                font-size: 14px;
            }
            
            .info-value {
                color: black;
                font-size: 14px;
                padding-left: 10px;
            }
            
            .info-section {
                margin-bottom: 30px;
            }
            
            .info-section-title {
                font-weight: bold;
                color: black;
                margin-bottom: 15px;
                font-size: 15px;
            }
            
            .info-section .info-item {
                padding-left: 25px;
            }
            
            .documents-table {
                width: 100%;
                border-collapse: collapse;
                border: 1px solid black;
            }
            
            .documents-table thead tr {
                background-color: #8B0000;
                color: white;
            }
            
            .documents-table th {
                padding: 12px;
                text-align: left;
                border: 1px solid black;
                font-weight: bold;
                font-size: 14px;
            }
            
            .documents-table td {
                padding: 10px 12px;
                text-align: left;
                border: 1px solid black;
                background-color: white;
                font-size: 13px;
            }
            
            .documents-table tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            
            .return-button {
                background-color: #8B0000;
                color: white;
                border: none;
                padding: 12px 25px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
                display: inline-block;
                margin: 20px 0 20px 30px;
                border-radius: 3px;
            }
            
            .return-button:hover {
                background-color: #6B0000;
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="page-title">Imported Invoice detail</div>
            
            <% if (importedinvoice != null) { 
                String invoiceCode = importedinvoice.getImportedCode();
                // Format code to INV001, INV002 format if it's numeric
                if (invoiceCode != null && invoiceCode.matches("\\d+")) {
                    invoiceCode = "INV" + String.format("%03d", Integer.parseInt(invoiceCode));
                }
            %>
                <div class="content-wrapper">
                    <div class="left-panel">
                        <div class="panel-title">Information</div>
                        
                        <div class="info-item">
                            <div class="info-label">Imported invoice code:</div>
                            <div class="info-value"><%= invoiceCode != null ? invoiceCode : "" %></div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Imported date:</div>
                            <div class="info-value"><%= sdfDisplay.format(importedinvoice.getImportedDate()) %></div>
                        </div>
                        
                        <div class="info-section">
                            <div class="info-section-title">Supplier information:</div>
                            <div class="info-item">
                                <div class="info-label">Supplier name:</div>
                                <div class="info-value"><%= importedinvoice.getSupplier().getSupplierName() %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Phone:</div>
                                <div class="info-value"><%= importedinvoice.getSupplier().getPhoneNumber() != null ? importedinvoice.getSupplier().getPhoneNumber() : "" %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Address:</div>
                                <div class="info-value"><%= importedinvoice.getSupplier().getAddress() != null ? importedinvoice.getSupplier().getAddress() : "" %></div>
                            </div>
                        </div>
                        
                        <div class="info-section">
                            <div class="info-section-title">Imported staff information:</div>
                            <div class="info-item">
                                <div class="info-label">Imported staff code:</div>
                                <div class="info-value"><%= importedinvoice.getLibstaff().getStaffCode() != null ? importedinvoice.getLibstaff().getStaffCode() : "" %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Full name:</div>
                                <div class="info-value">
                                    <%= importedinvoice.getLibstaff().getFullname().getFirstname() != null ? importedinvoice.getLibstaff().getFullname().getFirstname() : "" %>
                                    <%= importedinvoice.getLibstaff().getFullname().getMiddlename() != null ? importedinvoice.getLibstaff().getFullname().getMiddlename() : "" %>
                                    <%= importedinvoice.getLibstaff().getFullname().getLastname() != null ? importedinvoice.getLibstaff().getFullname().getLastname() : "" %>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Phone:</div>
                                <div class="info-value"><%= importedinvoice.getLibstaff().getPhonenumber() != null ? importedinvoice.getLibstaff().getPhonenumber() : "" %></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="right-panel">
                        <div class="panel-title">List imported Invoices</div>
                        
                        <% List<ImportedInvoiceDetail> details = importedinvoice.getListImportedInvoiceDetail(); %>
                        <% if (details != null && !details.isEmpty()) { %>
                            <table class="documents-table">
                                <thead>
                                    <tr>
                                        <th>Document ID</th>
                                        <th>Document name</th>
                                        <th>Author</th>
                                        <th>Publisher year</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (ImportedInvoiceDetail detail : details) { %>
                                        <tr>
                                            <td><%= detail.getDocument().getDocumentCode() != null ? detail.getDocument().getDocumentCode() : "" %></td>
                                            <td><%= detail.getDocument().getDocumentName() != null ? detail.getDocument().getDocumentName() : "" %></td>
                                            <td><%= detail.getDocument().getAuthor() != null ? detail.getDocument().getAuthor() : "" %></td>
                                            <td><%= detail.getDocument().getPublisherYear() != null ? sdfYear.format(detail.getDocument().getPublisherYear()) : "" %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } else { %>
                            <div style="padding: 40px; text-align: center; color: #666;">
                                No documents found in this imported invoice.
                            </div>
                        <% } %>
                    </div>
                </div>
                
                <a href="MainUI.jsp" class="return-button">Return to menu</a>
            <% } else { %>
                <div style="padding: 40px; text-align: center; color: #666;">
                    Invoice not found.
                </div>
                <a href="MainUI.jsp" class="return-button">Return to menu</a>
            <% } %>
        </div>
    </body>
</html>

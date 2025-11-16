package Controller;
import DAO.ImportedInvoiceDAO;
import Model.ImportedInvoice;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author anonymous
 */
@WebServlet(name = "ImportedInvoiceController", urlPatterns = {"/ImportedInvoiceController"})
public class ImportedInvoiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            String action = request.getParameter("action");
            
            if ("list".equals(action)) {
                // Lấy danh sách hóa đơn nhập của supplier
                String supplierIdStr = request.getParameter("supplierId");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                
                int supplierId = Integer.parseInt(supplierIdStr);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = sdf.parse(startDateStr);
                Date endDate = sdf.parse(endDateStr);
                
                ImportedInvoiceDAO dao = new ImportedInvoiceDAO();
                List<ImportedInvoice> listImportedInvoice = dao.getListImportedInvoice(startDate, endDate, supplierId);
                
                request.setAttribute("listImportedInvoice", listImportedInvoice);
                request.setAttribute("startDate", startDateStr);
                request.setAttribute("endDate", endDateStr);
                request.getRequestDispatcher("ShowListImportedInvoiceUI.jsp").forward(request, response);
                
                dao.closeConnection();
            } else if ("detail".equals(action)) {
                // Lấy chi tiết hóa đơn nhập
                String invoiceIdStr = request.getParameter("invoiceId");
                int invoiceId = Integer.parseInt(invoiceIdStr);
                
                ImportedInvoiceDAO dao = new ImportedInvoiceDAO();
                ImportedInvoice importedinvoice = dao.getImportedInvoice(invoiceId);
                
                request.setAttribute("importedinvoice", importedinvoice);
                request.getRequestDispatcher("DetailImportedInvoiceUI.jsp").forward(request, response);
                
                dao.closeConnection();
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi định dạng ngày tháng!");
            request.getRequestDispatcher("StatSuppliersUI.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("StatSuppliersUI.jsp").forward(request, response);
        }
    }
}

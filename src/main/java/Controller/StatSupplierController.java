package Controller;
import DAO.StatSuppliersDAO;
import Model.StatSuppliers;
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
@WebServlet(name = "StatSupplierController", urlPatterns = {"/StatSupplierController"})
public class StatSupplierController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            String startDateStr = request.getParameter("txtStartDate");
            String endDateStr = request.getParameter("txtEndDate");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);
            
            StatSuppliersDAO dao = new StatSuppliersDAO();
            List<StatSuppliers> listSupplier = dao.getListSupplier(startDate, endDate);
            
            request.setAttribute("listSupplier", listSupplier);
            request.getRequestDispatcher("StatSuppliersUI.jsp").forward(request, response);
            
            dao.closeConnection();
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

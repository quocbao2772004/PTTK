package Controller;
import DAO.ReaderDAO;
import Model.Reader;
import Model.Fullname;
import Model.Address;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author anonymous
 */
@WebServlet(name = "SignupController", urlPatterns = {"/SignupController"})
public class SignupController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Lấy thông tin từ form
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String email = request.getParameter("txtEmail");
            String phone = request.getParameter("txtPhone");
            String firstname = request.getParameter("txtFirstname");
            String middlename = request.getParameter("txtMiddlename");
            String lastname = request.getParameter("txtLastname");
            String homeNumber = request.getParameter("txtHomeNumber");
            String building = request.getParameter("txtBuilding");
            String street = request.getParameter("txtStreet");
            String ward = request.getParameter("txtWard");
            
            // Validate required fields
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                firstname == null || firstname.trim().isEmpty() ||
                lastname == null || lastname.trim().isEmpty() ||
                homeNumber == null || homeNumber.trim().isEmpty() ||
                street == null || street.trim().isEmpty() ||
                ward == null || ward.trim().isEmpty()) {
                request.setAttribute("error", "Please fill in all required fields.");
                request.getRequestDispatcher("Signup.jsp").forward(request, response);
                return;
            }
            
            // Tạo các đối tượng
            Fullname fullname = new Fullname();
            fullname.setFirstname(firstname.trim());
            fullname.setMiddlename(middlename != null ? middlename.trim() : "");
            fullname.setLastname(lastname.trim());
            
            Address address = new Address();
            address.setHomenumber(homeNumber.trim());
            address.setBuilding(building != null ? building.trim() : "");
            address.setStreet(street.trim());
            address.setWardcommune(ward.trim());
            
            Reader reader = new Reader();
            reader.setUsername(username.trim());
            reader.setPassword(password);
            reader.setEmail(email.trim());
            reader.setPhonenumber(phone.trim());
            reader.setFullname(fullname);
            reader.setAddress(address);
            reader.setRole("Reader");
            reader.setReputationScore(0);
            reader.setNote("");
            
            // Tạo Reader
            ReaderDAO readerDAO = new ReaderDAO();
            int readerId = readerDAO.createReader(reader);
            readerDAO.closeConnection();
            
            if (readerId > 0) {
                request.setAttribute("message", "Account created successfully! You can now login with your username and password.");
            } else {
                request.setAttribute("error", "Failed to create account. Username or email may already exist. Please try again.");
            }
            
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        }
    }
}


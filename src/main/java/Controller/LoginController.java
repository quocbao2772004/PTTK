package Controller;
import DAO.UserDAO;
import Model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author anonymous
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        Member member = userDAO.login(username, password);
        userDAO.closeConnection();
        
        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", member);
            session.setAttribute("username", member.getUsername());
            session.setAttribute("role", member.getRole());
            session.setAttribute("fullname", member.getFullname());
            
            // Redirect theo role
            if ("Reader".equals(member.getRole()) || "ManagementStaff".equals(member.getRole())) {
                response.sendRedirect("MainUI.jsp");
            } else {
                request.setAttribute("error", "Vai trò không hợp lệ!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Logout
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("Login.jsp");
    }
}


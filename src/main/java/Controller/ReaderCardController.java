package Controller;
import DAO.ReaderCardDAO;
import Model.ReaderCard;
import Model.Reader;
import Model.Fullname;
import Model.Address;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author anonymous
 */
@WebServlet(name = "ReaderCardController", urlPatterns = {"/ReaderCardController"})
@MultipartConfig(maxFileSize = 10485760) // 10MB
public class ReaderCardController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Kiểm tra session
            jakarta.servlet.http.HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
                return;
            }
            
            Reader currentReader = (Reader) session.getAttribute("user");
            if (!"Reader".equals(currentReader.getRole())) {
                response.sendRedirect("Login.jsp");
                return;
            }
            
            // Lấy thông tin từ form (multipart)
            String cardcode = null;
            String firstname = null;
            String middlename = null;
            String lastname = null;
            String email = null;
            String phone = null;
            String homeNumber = null;
            String building = null;
            String street = null;
            String ward = null;
            String userimagePath = null;
            
            // Tạo thư mục lưu ảnh nếu chưa có
            String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator + "reader_images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Lấy tất cả các Part từ request
            for (Part part : request.getParts()) {
                String partName = part.getName();
                
                if ("imageuser".equals(partName)) {
                    // Xử lý upload image
                    try {
                        String fileName = part.getSubmittedFileName();
                        long fileSize = part.getSize();
                        // Kiểm tra xem có file được upload không
                        if (fileName != null && !fileName.isEmpty() && fileSize > 0) {
                            // Tạo tên file unique
                            String fileExtension = "";
                            int lastDot = fileName.lastIndexOf('.');
                            if (lastDot > 0) {
                                fileExtension = fileName.substring(lastDot);
                            }
                            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                            String filePath = uploadPath + File.separator + uniqueFileName;
                            
                            // Lưu file
                            Files.copy(part.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                            
                            // Lưu đường dẫn tương đối (để truy cập qua web)
                            userimagePath = "uploads/reader_images/" + uniqueFileName;
                        }
                    } catch (Exception e) {
                        System.out.println("Warning: Could not process image upload: " + e.getMessage());
                        e.printStackTrace();
                        userimagePath = null;
                    }
                } else {
                    // Lấy các parameter text
                    try {
                        java.io.BufferedReader reader = new java.io.BufferedReader(
                            new java.io.InputStreamReader(part.getInputStream(), "UTF-8"));
                        StringBuilder value = new StringBuilder();
                        String line;
                        while ((line = reader.readLine()) != null) {
                            value.append(line);
                        }
                        reader.close();
                        
                        String paramValue = value.toString();
                        
                        if ("txtCardCode".equals(partName)) {
                            cardcode = paramValue;
                        } else if ("txtFirstname".equals(partName)) {
                            firstname = paramValue;
                        } else if ("txtMiddlename".equals(partName)) {
                            middlename = paramValue;
                        } else if ("txtLastname".equals(partName)) {
                            lastname = paramValue;
                        } else if ("txtEmail".equals(partName)) {
                            email = paramValue;
                        } else if ("txtPhone".equals(partName)) {
                            phone = paramValue;
                        } else if ("txtHomeNumber".equals(partName)) {
                            homeNumber = paramValue;
                        } else if ("txtBuilding".equals(partName)) {
                            building = paramValue;
                        } else if ("txtStreet".equals(partName)) {
                            street = paramValue;
                        } else if ("txtWard".equals(partName)) {
                            ward = paramValue;
                        }
                    } catch (Exception e) {
                        System.out.println("Warning: Could not read parameter " + partName + ": " + e.getMessage());
                    }
                }
            }
            
            // Cập nhật thông tin Reader từ form (nếu có thay đổi)
            // Lấy Reader hiện tại từ session
            Reader reader = currentReader;
            
            // Cập nhật Fullname
            if (reader.getFullname() != null) {
                reader.getFullname().setFirstname(firstname);
                reader.getFullname().setMiddlename(middlename != null ? middlename : "");
                reader.getFullname().setLastname(lastname);
            } else {
                Fullname fullname = new Fullname();
                fullname.setFirstname(firstname);
                fullname.setMiddlename(middlename != null ? middlename : "");
                fullname.setLastname(lastname);
                reader.setFullname(fullname);
            }
            
            // Cập nhật Address
            if (reader.getAddress() != null) {
                reader.getAddress().setHomenumber(homeNumber);
                reader.getAddress().setBuilding(building != null ? building : "");
                reader.getAddress().setStreet(street);
                reader.getAddress().setWardcommune(ward);
            } else {
                Address address = new Address();
                address.setHomenumber(homeNumber);
                address.setBuilding(building != null ? building : "");
                address.setStreet(street);
                address.setWardcommune(ward);
                reader.setAddress(address);
            }
            
            // Cập nhật thông tin khác
            reader.setEmail(email);
            reader.setPhonenumber(phone);
            
            // Kiểm tra xem Reader đã có card chưa
            ReaderCardDAO dao = new ReaderCardDAO();
            if (dao.hasReaderCard(reader.getId())) {
                dao.closeConnection();
                request.setAttribute("error", "You already have a reader card. Each user can only have one card.");
                request.getRequestDispatcher("RegisterReaderCardUI.jsp").forward(request, response);
                return;
            }
            
            // Tạo ReaderCard
            ReaderCard readercard = new ReaderCard();
            readercard.setCardcode(cardcode);
            readercard.setUserimagePath(userimagePath);
            readercard.setRegisterdate(new Date());
            readercard.setStatus("Active");
            readercard.setReader(reader);
            
            // Gọi DAO để lưu ReaderCard
            boolean result = dao.createNewCard(readercard);
            
            if (result) {
                // Cập nhật session với thông tin mới
                session.setAttribute("user", reader);
                request.setAttribute("message", "Reader card registered successfully!");
            } else {
                request.setAttribute("error", "Failed to register reader card. Please try again.");
            }
            
            dao.closeConnection();
            request.getRequestDispatcher("RegisterReaderCardUI.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("RegisterReaderCardUI.jsp").forward(request, response);
        }
    }
}

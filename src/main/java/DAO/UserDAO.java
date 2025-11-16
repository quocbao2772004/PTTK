package DAO;
import Model.Member;
import Model.Reader;
import Model.ManagementStaff;
import Model.Fullname;
import Model.Address;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author anonymous
 */
public class UserDAO extends DAO {
    
    public UserDAO() {
        super();
    }
    
    public Member login(String username, String password) {
        String sql = "SELECT m.id, m.username, m.password, m.email, m.phonenumber, m.role, m.note, " +
                     "f.id as fullnameId, f.firstname, f.middlename, f.lastname, " +
                     "a.id as addressId, a.homenumber, a.building, a.street, a.wardcommune " +
                     "FROM tblMember m " +
                     "INNER JOIN tblFullname f ON m.tblFullnameid = f.id " +
                     "INNER JOIN tblAddress a ON m.tblAddressid = a.id " +
                     "WHERE m.username = ? AND m.password = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Fullname fullname = new Fullname();
                fullname.setId(rs.getInt("fullnameId"));
                fullname.setFirstname(rs.getString("firstname"));
                fullname.setMiddlename(rs.getString("middlename"));
                fullname.setLastname(rs.getString("lastname"));
                
                Address address = new Address();
                address.setId(rs.getInt("addressId"));
                address.setHomenumber(rs.getString("homenumber"));
                address.setBuilding(rs.getString("building"));
                address.setStreet(rs.getString("street"));
                address.setWardcommune(rs.getString("wardcommune"));
                
                String role = rs.getString("role");
                Member member = null;
                
                int memberId = rs.getInt("id");
                
                if ("Reader".equals(role)) {
                    // Lấy thông tin Reader
                    Reader reader = getReaderByMemberId(memberId);
                    if (reader != null) {
                        // reader.setId() đã được set trong getReaderByMemberId() với Reader ID
                        // Cần lưu memberId để có thể truy cập sau này nếu cần
                        reader.setUsername(rs.getString("username"));
                        reader.setPassword(rs.getString("password"));
                        reader.setEmail(rs.getString("email"));
                        reader.setPhonenumber(rs.getString("phonenumber"));
                        reader.setRole(role);
                        reader.setNote(rs.getString("note"));
                        reader.setFullname(fullname);
                        reader.setAddress(address);
                        member = reader;
                    }
                } else if ("ManagementStaff".equals(role)) {
                    // Lấy thông tin ManagementStaff
                    ManagementStaff staff = getManagementStaffByMemberId(memberId);
                    if (staff != null) {
                        staff.setId(memberId);
                        staff.setUsername(rs.getString("username"));
                        staff.setPassword(rs.getString("password"));
                        staff.setEmail(rs.getString("email"));
                        staff.setPhonenumber(rs.getString("phonenumber"));
                        staff.setRole(role);
                        staff.setNote(rs.getString("note"));
                        staff.setFullname(fullname);
                        staff.setAddress(address);
                        member = staff;
                    }
                }
                
                rs.close();
                ps.close();
                
                return member;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private Reader getReaderByMemberId(int memberId) {
        String sql = "SELECT r.id, r.reputationScore, r.note " +
                     "FROM tblReader r " +
                     "WHERE r.tblMemberid = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Reader reader = new Reader();
                reader.setId(rs.getInt("id")); // Set Reader ID (từ tblReader)
                reader.setReputationScore(rs.getInt("reputationScore"));
                reader.setNote(rs.getString("note"));
                
                rs.close();
                ps.close();
                
                return reader;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private ManagementStaff getManagementStaffByMemberId(int memberId) {
        String sql = "SELECT s.id, s.staffCode, s.position " +
                     "FROM tblStaff s " +
                     "INNER JOIN tblMember m ON s.tblMemberid = m.id " +
                     "WHERE m.id = ? AND m.role = 'ManagementStaff'";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ManagementStaff staff = new ManagementStaff();
                staff.setStaffCode(rs.getString("staffCode"));
                staff.setPosition(rs.getString("position"));
                
                rs.close();
                ps.close();
                
                return staff;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}


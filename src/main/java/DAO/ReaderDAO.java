package DAO;
import Model.Reader;
import Model.Fullname;
import Model.Address;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author anonymous
 */
public class ReaderDAO extends DAO {
    
    public ReaderDAO() {
        super();
    }
    
    public int createReader(Reader reader) {
        try {
            // Tạo Fullname trước
            int fullnameId = createFullname(reader.getFullname());
            if (fullnameId == -1) return -1;
            
            // Tạo Address
            int addressId = createAddress(reader.getAddress());
            if (addressId == -1) return -1;
            
            // Tạo Member (Reader)
            String sql = "INSERT INTO tblMember (username, password, tblFullnameid, email, phonenumber, tblAddressid, role, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, reader.getUsername());
            ps.setString(2, reader.getPassword());
            ps.setInt(3, fullnameId);
            ps.setString(4, reader.getEmail());
            ps.setString(5, reader.getPhonenumber());
            ps.setInt(6, addressId);
            ps.setString(7, reader.getRole());
            ps.setString(8, reader.getNote());
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int memberId = -1;
            if (rs.next()) {
                memberId = rs.getInt(1);
            }
            rs.close();
            ps.close();
            
            if (memberId == -1) return -1;
            
            // Tạo Reader
            sql = "INSERT INTO tblReader (reputationScore, note, tblMemberid) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, reader.getReputationScore());
            ps.setString(2, reader.getNote());
            ps.setInt(3, memberId);
            
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            int readerId = -1;
            if (rs.next()) {
                readerId = rs.getInt(1);
            }
            rs.close();
            ps.close();
            
            return readerId;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    private int createFullname(Fullname fullname) {
        try {
            String sql = "INSERT INTO tblFullname (firstname, middlename, lastname) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, fullname.getFirstname());
            ps.setString(2, fullname.getMiddlename());
            ps.setString(3, fullname.getLastname());
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int id = -1;
            if (rs.next()) {
                id = rs.getInt(1);
            }
            rs.close();
            ps.close();
            
            return id;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    private int createAddress(Address address) {
        try {
            String sql = "INSERT INTO tblAddress (homenumber, building, street, wardcommune) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, address.getHomenumber());
            ps.setString(2, address.getBuilding());
            ps.setString(3, address.getStreet());
            ps.setString(4, address.getWardcommune());
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int id = -1;
            if (rs.next()) {
                id = rs.getInt(1);
            }
            rs.close();
            ps.close();
            
            return id;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
}


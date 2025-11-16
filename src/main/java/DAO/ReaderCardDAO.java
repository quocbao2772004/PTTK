package DAO;
import Model.ReaderCard;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

/**
 *
 * @author anonymous
 */
public class ReaderCardDAO extends DAO {
    
    public ReaderCardDAO() {
        super();
    }
    
    public boolean hasReaderCard(int readerId) {
        String sql = "SELECT COUNT(*) as count FROM tblReaderCard WHERE tblReaderid = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, readerId);
            
            ResultSet rs = ps.executeQuery();
            boolean hasCard = false;
            if (rs.next()) {
                hasCard = rs.getInt("count") > 0;
            }
            
            rs.close();
            ps.close();
            
            return hasCard;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public String getCardCodeByReaderId(int readerId) {
        String sql = "SELECT cardcode FROM tblReaderCard WHERE tblReaderid = ? LIMIT 1";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, readerId);
            
            ResultSet rs = ps.executeQuery();
            String cardCode = null;
            if (rs.next()) {
                cardCode = rs.getString("cardcode");
            }
            
            rs.close();
            ps.close();
            
            return cardCode;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public boolean createNewCard(ReaderCard readercard) {
        String sql = "INSERT INTO tblReaderCard (cardcode, userimage, registerdate, status, tblReaderid) VALUES (?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, readercard.getCardcode());
            ps.setString(2, readercard.getUserimagePath()); // Lưu đường dẫn thay vì BLOB
            ps.setDate(3, new Date(readercard.getRegisterdate().getTime()));
            ps.setString(4, readercard.getStatus());
            ps.setInt(5, readercard.getReader().getId());
            
            int result = ps.executeUpdate();
            ps.close();
            
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}


package DAO;
import Model.StatSuppliers;
import Model.Supplier;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author anonymous
 */
public class StatSuppliersDAO extends DAO {
    
    public StatSuppliersDAO() {
        super();
    }
    
    public List<StatSuppliers> getListSupplier(Date startdate, Date enddate) {
        List<StatSuppliers> list = new ArrayList<>();
        String sql = "SELECT s.id, s.supplierCode, s.supplierName, s.phoneNumber, s.address, " +
                     "COUNT(ii.id) as importQuantity " +
                     "FROM tblSupplier s " +
                     "INNER JOIN tblImportedInvoice ii ON s.id = ii.tblSupplierid " +
                     "WHERE ii.importedDate BETWEEN ? AND ? " +
                     "GROUP BY s.id, s.supplierCode, s.supplierName, s.phoneNumber, s.address " +
                     "HAVING COUNT(ii.id) > 0 " +
                     "ORDER BY importQuantity DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(startdate.getTime()));
            ps.setDate(2, new java.sql.Date(enddate.getTime()));
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setSupplierCode(rs.getString("supplierCode"));
                supplier.setSupplierName(rs.getString("supplierName"));
                supplier.setPhoneNumber(rs.getString("phoneNumber"));
                supplier.setAddress(rs.getString("address"));
                
                StatSuppliers stat = new StatSuppliers();
                stat.setSupplier(supplier);
                stat.setImportQuantity(rs.getInt("importQuantity"));
                
                list.add(stat);
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
}

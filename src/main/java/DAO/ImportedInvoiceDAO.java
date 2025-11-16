package DAO;
import Model.ImportedInvoice;
import Model.ImportedInvoiceDetail;
import Model.Supplier;
import Model.LibraryStaff;
import Model.Document;
import Model.Fullname;
import Model.Address;
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
public class ImportedInvoiceDAO extends DAO {
    
    public ImportedInvoiceDAO() {
        super();
    }
    
    public List<ImportedInvoice> getListImportedInvoice(Date startdate, Date enddate, int supplierId) {
        List<ImportedInvoice> list = new ArrayList<>();
        String sql = "SELECT ii.id, ii.importedCode, ii.importedDate, " +
                     "ii.tblSupplierid, ii.tblStaffid " +
                     "FROM tblImportedInvoice ii " +
                     "WHERE ii.tblSupplierid = ? AND ii.importedDate BETWEEN ? AND ? " +
                     "ORDER BY ii.importedDate DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, supplierId);
            ps.setDate(2, new java.sql.Date(startdate.getTime()));
            ps.setDate(3, new java.sql.Date(enddate.getTime()));
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportedInvoice invoice = new ImportedInvoice();
                invoice.setId(rs.getInt("id"));
                invoice.setImportedCode(rs.getString("importedCode"));
                invoice.setImportedDate(rs.getDate("importedDate"));
                
                // Load supplier
                Supplier supplier = getSupplierById(rs.getInt("tblSupplierid"));
                invoice.setSupplier(supplier);
                
                // Load library staff
                LibraryStaff libstaff = getLibraryStaffById(rs.getInt("tblStaffid"));
                invoice.setLibstaff(libstaff);
                
                list.add(invoice);
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public ImportedInvoice getImportedInvoice(int invoiceId) {
        String sql = "SELECT ii.id, ii.importedCode, ii.importedDate, " +
                     "ii.tblSupplierid, ii.tblStaffid " +
                     "FROM tblImportedInvoice ii " +
                     "WHERE ii.id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, invoiceId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ImportedInvoice invoice = new ImportedInvoice();
                invoice.setId(rs.getInt("id"));
                invoice.setImportedCode(rs.getString("importedCode"));
                invoice.setImportedDate(rs.getDate("importedDate"));
                
                // Load supplier
                Supplier supplier = getSupplierById(rs.getInt("tblSupplierid"));
                invoice.setSupplier(supplier);
                
                // Load library staff
                LibraryStaff libstaff = getLibraryStaffById(rs.getInt("tblStaffid"));
                invoice.setLibstaff(libstaff);
                
                // Load invoice details
                List<ImportedInvoiceDetail> details = getImportedInvoiceDetails(invoice.getId());
                invoice.setListImportedInvoiceDetail(details);
                
                rs.close();
                ps.close();
                
                return invoice;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private Supplier getSupplierById(int supplierId) {
        String sql = "SELECT * FROM tblSupplier WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, supplierId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setSupplierCode(rs.getString("supplierCode"));
                supplier.setSupplierName(rs.getString("supplierName"));
                supplier.setPhoneNumber(rs.getString("phoneNumber"));
                supplier.setAddress(rs.getString("address"));
                
                rs.close();
                ps.close();
                
                return supplier;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private LibraryStaff getLibraryStaffById(int staffId) {
        String sql = "SELECT s.id, s.staffCode, s.position, " +
                     "m.id as memberId, m.username, m.password, m.email, m.phonenumber, m.role, m.note, " +
                     "f.id as fullnameId, f.firstname, f.middlename, f.lastname, " +
                     "a.id as addressId, a.homenumber, a.building, a.street, a.wardcommune " +
                     "FROM tblStaff s " +
                     "INNER JOIN tblMember m ON s.tblMemberid = m.id " +
                     "INNER JOIN tblFullname f ON m.tblFullnameid = f.id " +
                     "INNER JOIN tblAddress a ON m.tblAddressid = a.id " +
                     "WHERE s.id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, staffId);
            
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
                
                LibraryStaff libstaff = new LibraryStaff();
                libstaff.setId(rs.getInt("id"));
                libstaff.setStaffCode(rs.getString("staffCode"));
                libstaff.setPosition(rs.getString("position"));
                libstaff.setUsername(rs.getString("username"));
                libstaff.setPassword(rs.getString("password"));
                libstaff.setEmail(rs.getString("email"));
                libstaff.setPhonenumber(rs.getString("phonenumber"));
                libstaff.setRole(rs.getString("role"));
                libstaff.setNote(rs.getString("note"));
                libstaff.setFullname(fullname);
                libstaff.setAddress(address);
                
                rs.close();
                ps.close();
                
                return libstaff;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private List<ImportedInvoiceDetail> getImportedInvoiceDetails(int invoiceId) {
        List<ImportedInvoiceDetail> details = new ArrayList<>();
        String sql = "SELECT iid.id, iid.code, iid.tblDocumentid " +
                     "FROM tblImportedInvoiceDetail iid " +
                     "WHERE iid.tblImportedInvoiceid = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, invoiceId);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportedInvoiceDetail detail = new ImportedInvoiceDetail();
                detail.setId(rs.getInt("id"));
                detail.setCode(rs.getString("code"));
                
                // Load document
                Document document = getDocumentById(rs.getInt("tblDocumentid"));
                detail.setDocument(document);
                
                details.add(detail);
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return details;
    }
    
    private Document getDocumentById(int documentId) {
        String sql = "SELECT * FROM tblDocument WHERE id = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, documentId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Document document = new Document();
                document.setId(rs.getInt("id"));
                document.setDocumentCode(rs.getString("documentCode"));
                document.setDocumentName(rs.getString("documentName"));
                document.setAuthor(rs.getString("author"));
                document.setPublisherYear(rs.getDate("publisherYear"));
                
                rs.close();
                ps.close();
                
                return document;
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}

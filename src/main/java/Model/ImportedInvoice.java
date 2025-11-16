package Model;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author anonymous
 */
public class ImportedInvoice {
    private int id;
    private String importedCode;
    private Date importedDate;
    private Supplier supplier;
    private LibraryStaff libstaff;
    private List<ImportedInvoiceDetail> listImportedInvoiceDetail;

    public ImportedInvoice() {
        this.listImportedInvoiceDetail = new ArrayList<>();
    }

    public ImportedInvoice(int id, String importedCode, Date importedDate, Supplier supplier, LibraryStaff libstaff, List<ImportedInvoiceDetail> listImportedInvoiceDetail) {
        this.id = id;
        this.importedCode = importedCode;
        this.importedDate = importedDate;
        this.supplier = supplier;
        this.libstaff = libstaff;
        this.listImportedInvoiceDetail = listImportedInvoiceDetail != null ? listImportedInvoiceDetail : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImportedCode() {
        return importedCode;
    }

    public void setImportedCode(String importedCode) {
        this.importedCode = importedCode;
    }

    public Date getImportedDate() {
        return importedDate;
    }

    public void setImportedDate(Date importedDate) {
        this.importedDate = importedDate;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public LibraryStaff getLibstaff() {
        return libstaff;
    }

    public void setLibstaff(LibraryStaff libstaff) {
        this.libstaff = libstaff;
    }

    public List<ImportedInvoiceDetail> getListImportedInvoiceDetail() {
        return listImportedInvoiceDetail;
    }

    public void setListImportedInvoiceDetail(List<ImportedInvoiceDetail> listImportedInvoiceDetail) {
        this.listImportedInvoiceDetail = listImportedInvoiceDetail;
    }
}

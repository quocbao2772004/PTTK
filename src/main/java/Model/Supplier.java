package Model;

/**
 *
 * @author anonymous
 */
public class Supplier {
    private int id;
    private String supplierCode;
    private String supplierName;
    private String phoneNumber;
    private String address;

    public Supplier() {
    }

    public Supplier(int id, String supplierCode, String supplierName, String phoneNumber, String address) {
        this.id = id;
        this.supplierCode = supplierCode;
        this.supplierName = supplierName;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}

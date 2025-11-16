package Model;

/**
 *
 * @author anonymous
 */
public class Staff extends Member {
    private String staffCode;
    private String position;

    public Staff() {
        super();
    }

    public Staff(int id, String username, String password, Fullname fullname, String email, String phonenumber, Address address, String role, String note, String staffCode, String position) {
        super(id, username, password, fullname, email, phonenumber, address, role, note);
        this.staffCode = staffCode;
        this.position = position;
    }

    public String getStaffCode() {
        return staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}

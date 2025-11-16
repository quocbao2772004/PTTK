package Model;

/**
 *
 * @author anonymous
 */
public class ManagementStaff extends Staff {
    
    public ManagementStaff() {
        super();
    }

    public ManagementStaff(int id, String username, String password, Fullname fullname, String email, String phonenumber, Address address, String role, String note, String staffCode, String position) {
        super(id, username, password, fullname, email, phonenumber, address, role, note, staffCode, position);
    }
}

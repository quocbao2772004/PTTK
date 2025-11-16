package Model;

/**
 *
 * @author anonymous
 */
public class Reader extends Member {
    private int reputationScore;
    private String note;

    public Reader() {
        super();
    }

    public Reader(int id, String username, String password, Fullname fullname, String email, String phonenumber, Address address, String role, String note, int reputationScore) {
        super(id, username, password, fullname, email, phonenumber, address, role, note);
        this.reputationScore = reputationScore;
        this.note = note;
    }

    public int getReputationScore() {
        return reputationScore;
    }

    public void setReputationScore(int reputationScore) {
        this.reputationScore = reputationScore;
    }

    @Override
    public String getNote() {
        return note;
    }

    @Override
    public void setNote(String note) {
        this.note = note;
    }
}

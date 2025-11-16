package Model;
import java.util.Date;

/**
 *
 * @author anonymous
 */
public class ReaderCard {
    private int id;
    private String cardcode;
    private String userimagePath;
    private Date registerdate;
    private String status;
    private Reader reader;

    public ReaderCard() {
    }

    public ReaderCard(int id, String cardcode, String userimagePath, Date registerdate, String status, Reader reader) {
        this.id = id;
        this.cardcode = cardcode;
        this.userimagePath = userimagePath;
        this.registerdate = registerdate;
        this.status = status;
        this.reader = reader;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCardcode() {
        return cardcode;
    }

    public void setCardcode(String cardcode) {
        this.cardcode = cardcode;
    }

    public String getUserimagePath() {
        return userimagePath;
    }

    public void setUserimagePath(String userimagePath) {
        this.userimagePath = userimagePath;
    }

    public Date getRegisterdate() {
        return registerdate;
    }

    public void setRegisterdate(Date registerdate) {
        this.registerdate = registerdate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }
}

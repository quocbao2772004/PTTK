package Model;
import java.util.Date;

/**
 *
 * @author anonymous
 */
public class Document {
    private int id;
    private String documentCode;
    private String documentName;
    private String author;
    private Date publisherYear;

    public Document() {
    }

    public Document(int id, String documentCode, String documentName, String author, Date publisherYear) {
        this.id = id;
        this.documentCode = documentCode;
        this.documentName = documentName;
        this.author = author;
        this.publisherYear = publisherYear;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDocumentCode() {
        return documentCode;
    }

    public void setDocumentCode(String documentCode) {
        this.documentCode = documentCode;
    }

    public String getDocumentName() {
        return documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getPublisherYear() {
        return publisherYear;
    }

    public void setPublisherYear(Date publisherYear) {
        this.publisherYear = publisherYear;
    }
}

package Model;

/**
 *
 * @author anonymous
 */
public class ImportedInvoiceDetail {
    private int id;
    private String code;
    private Document document;

    public ImportedInvoiceDetail() {
    }

    public ImportedInvoiceDetail(int id, String code, Document document) {
        this.id = id;
        this.code = code;
        this.document = document;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }
}

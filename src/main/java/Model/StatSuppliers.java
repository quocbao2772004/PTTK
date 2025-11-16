package Model;

/**
 *
 * @author anonymous
 */
public class StatSuppliers {
    private Supplier supplier;
    private int importQuantity;

    public StatSuppliers() {
    }

    public StatSuppliers(Supplier supplier, int importQuantity) {
        this.supplier = supplier;
        this.importQuantity = importQuantity;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public int getImportQuantity() {
        return importQuantity;
    }

    public void setImportQuantity(int importQuantity) {
        this.importQuantity = importQuantity;
    }
}

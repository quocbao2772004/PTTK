package Model;

/**
 *
 * @author anonymous
 */
public class Address {
    private int id;
    private String homenumber;
    private String building;
    private String street;
    private String wardcommune;

    public Address() {
    }

    public Address(int id, String homenumber, String building, String street, String wardcommune) {
        this.id = id;
        this.homenumber = homenumber;
        this.building = building;
        this.street = street;
        this.wardcommune = wardcommune;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHomenumber() {
        return homenumber;
    }

    public void setHomenumber(String homenumber) {
        this.homenumber = homenumber;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getWardcommune() {
        return wardcommune;
    }

    public void setWardcommune(String wardcommune) {
        this.wardcommune = wardcommune;
    }
}

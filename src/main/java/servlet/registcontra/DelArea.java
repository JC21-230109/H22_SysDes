package servlet.registcontra;

public class DelArea {
    private String delAreaCode;
    private String delAreaName;

    public DelArea(String delAreaCode, String delAreaName) {
        this.delAreaCode = delAreaCode;
        this.delAreaName = delAreaName;
    }

    public String getDelAreaCode() {
        return delAreaCode;
    }

    public String getDelAreaName() {
        return delAreaName;
    }
}
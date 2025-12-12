package beans;



public class Area {
	String areaCode;
	String areaName;
	public Area(String areaCode,String areaName) {
		this.areaCode=areaCode;
		this.areaName=areaName;
	}
	
	
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	
}

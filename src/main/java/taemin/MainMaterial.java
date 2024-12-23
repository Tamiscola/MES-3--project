package taemin;

public class MainMaterial {
	private int no;
	private String color;
	private int quantity;
	private String material;
	private String defection;
	private String waterProof;
	private String windProof;
	private String supplyCompany;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
	public String getDefection() {
		return defection;
	}
	public void setDefection(String defection) {
		this.defection = defection;
	}
	public String getWaterProof() {
		return waterProof;
	}
	public void setWaterProof(String waterProof) {
		this.waterProof = waterProof;
	}
	public String getWindProof() {
		return windProof;
	}
	public void setWindProof(String windProof) {
		this.windProof = windProof;
	}
	public String getSupplyCompany() {
		return supplyCompany;
	}
	public void setSupplyCompany(String supplyCompany) {
		this.supplyCompany = supplyCompany;
	}
	@Override
	public String toString() {
		return "mainMaterial [no=" + no + ", color=" + color + ", quantity=" + quantity + ", material=" + material
				+ ", defection=" + defection + ", waterProof=" + waterProof + ", windProof=" + windProof
				+ ", supplyCompany=" + supplyCompany + "]";
	}
	
}

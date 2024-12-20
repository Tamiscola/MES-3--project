package com;

public class SupplyContact {
	private int sup_no;
	private String sup_name;
	private String sup_phone;
	private String sup_address;
	private String sup_email;
	
	public int getSup_no() {
		return sup_no;
	}
	public void setSup_no(int sup_no) {
		this.sup_no = sup_no;
	}
	
	public String getSup_name() {
		return sup_name;
	}
	public void setSup_name(String sup_name) {
		this.sup_name = sup_name;
	}
	public String getSup_phone() {
		return sup_phone;
	}
	public void setSup_phone(String sup_phone) {
		this.sup_phone = sup_phone;
	}
	public String getSup_address() {
		return sup_address;
	}
	public void setSup_address(String sup_address) {
		this.sup_address = sup_address;
	}
	public String getSup_email() {
		return sup_email;
	}
	public void setSup_email(String sup_email) {
		this.sup_email = sup_email;
	}
	@Override
	public String toString() {
		return "supplyContact [sup_name=" + sup_name + ", sup_phone=" + sup_phone + ", sup_address=" + sup_address
				+ ", sup_email=" + sup_email + "]";
	}
	
	
}
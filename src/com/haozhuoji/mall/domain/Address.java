package com.haozhuoji.mall.domain;

import java.io.Serializable;

public class Address implements Serializable{
	private static final long serialVersionUID = 3435951705776497838L;
	
	private Long addressID;
	
	private Long userID;
	
	private String name;
	
	private String address;
	
	private String cellphone;
	
	private Long flag;
	
	private Long paramFlag;
	
	public Long getParamFlag() {
		return paramFlag;
	}

	public void setParamFlag(Long paramFlag) {
		this.paramFlag = paramFlag;
	}

	public Long getAddressID() {
		return addressID;
	}

	public void setAddressID(Long addressID) {
		this.addressID = addressID;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public Long getFlag() {
		return flag;
	}

	public void setFlag(Long flag) {
		this.flag = flag;
	}
}

package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.List;

public class GoodsType implements Serializable{
	private static final long serialVersionUID = 3435951705776497838L;
	
	private Long typeID;
	
	private String typeName;
	
	private Long fatherID;

	private String fullTypeName;
	
	private String fullTypeID;
	
	private List<GoodsType> subTypeList;
	public List<GoodsType> getSubTypeList() {
		return subTypeList;
	}

	public void setSubTypeList(List<GoodsType> subTypeList) {
		this.subTypeList = subTypeList;
	}

	public String getFullTypeName() {
		return fullTypeName;
	}

	public void setFullTypeName(String fullTypeName) {
		this.fullTypeName = fullTypeName;
	}

	public String getFullTypeID() {
		return fullTypeID;
	}

	public void setFullTypeID(String fullTypeID) {
		this.fullTypeID = fullTypeID;
	}

	public Long getTypeID() {
		return typeID;
	}

	public void setTypeID(Long typeID) {
		this.typeID = typeID;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Long getFatherID() {
		return fatherID;
	}

	public void setFatherID(Long fatherID) {
		this.fatherID = fatherID;
	}
}

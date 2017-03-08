package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;

public class Activity implements Serializable{
	private static final long serialVersionUID = -7829817370594681956L;
	private Long activityID;
	private Long TypeID;
	private String fullTypeName;
	private Double rech;
	private Double sub;
	private Date beginDateTime;
	private Date endDateTime;
	private Long userID;
	
	//total price
	private Double totalPrice;
	
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Long getTypeID() {
		return TypeID;
	}
	public void setTypeID(Long typeID) {
		TypeID = typeID;
	}
	public String getFullTypeName() {
		return fullTypeName;
	}
	public void setFullTypeName(String fullTypeName) {
		this.fullTypeName = fullTypeName;
	}
	public Long getUserID() {
		return userID;
	}
	public void setUserID(Long userID) {
		this.userID = userID;
	}
	public Long getActivityID() {
		return activityID;
	}
	public void setActivityID(Long activityID) {
		this.activityID = activityID;
	}
	public Double getRech() {
		return rech;
	}
	public void setRech(Double rech) {
		this.rech = rech;
	}
	public Double getSub() {
		return sub;
	}
	public void setSub(Double sub) {
		this.sub = sub;
	}
	public Date getBeginDateTime() {
		return beginDateTime;
	}
	public void setBeginDateTime(Date beginDateTime) {
		this.beginDateTime = beginDateTime;
	}
	public Date getEndDateTime() {
		return endDateTime;
	}
	public void setEndDateTime(Date endDateTime) {
		this.endDateTime = endDateTime;
	}
}

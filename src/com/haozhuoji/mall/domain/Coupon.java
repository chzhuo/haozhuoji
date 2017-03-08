package com.haozhuoji.mall.domain;

import java.util.Date;

public class Coupon {
	private Long couponID;
	private String couponNumber;
	private Long typeID;
	private Long bindUserID;
	private Double rech;
	private Double sub;
	private Date beginDateTime;
	private Date endDateTime;
	private Date createDateTime;
	private Boolean issue;
	private Boolean used;
	//
	private Integer createCount;
	private Double totalPrice;
	private String fullTypeName;
	
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public Integer getCreateCount() {
		return createCount;
	}
	public void setCreateCount(Integer createCount) {
		this.createCount = createCount;
	}
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getFullTypeName() {
		return fullTypeName;
	}
	public void setFullTypeName(String fullTypeName) {
		this.fullTypeName = fullTypeName;
	}
	public Boolean getIssue() {
		return issue;
	}
	public void setIssue(Boolean issue) {
		this.issue = issue;
	}
	public Boolean getUsed() {
		return used;
	}
	public void setUsed(Boolean used) {
		this.used = used;
	}
	public Long getCouponID() {
		return couponID;
	}
	public void setCouponID(Long couponID) {
		this.couponID = couponID;
	}
	public String getCouponNumber() {
		return couponNumber;
	}
	public void setCouponNumber(String couponNumber) {
		this.couponNumber = couponNumber;
	}
	
	public Long getTypeID() {
		return typeID;
	}
	public void setTypeID(Long typeID) {
		this.typeID = typeID;
	}
	public Long getBindUserID() {
		return bindUserID;
	}
	public void setBindUserID(Long bindUserID) {
		this.bindUserID = bindUserID;
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

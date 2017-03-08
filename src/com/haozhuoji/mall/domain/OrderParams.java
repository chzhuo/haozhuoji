package com.haozhuoji.mall.domain;

import java.util.Date;

public class OrderParams {
	private Double activitySub;
	private Long addressID;
	private String couponNumber;
	private Date date;
	private Long orderTimeStamp;
	private Long periodID;
	private Double sendPrice;
	private String timePeriod;
	private Double totalGoodsPrice;
	private Double totalPrice;
	private String leaveMess;
	
	public String getLeaveMess() {
		return leaveMess;
	}
	public void setLeaveMess(String leaveMess) {
		this.leaveMess = leaveMess;
	}
	public Double getTotalGoodsPrice() {
		return totalGoodsPrice;
	}
	public void setTotalGoodsPrice(Double totalGoodsPrice) {
		this.totalGoodsPrice = totalGoodsPrice;
	}
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Double getActivitySub() {
		return activitySub;
	}
	public void setActivitySub(Double activitySub) {
		this.activitySub = activitySub;
	}
	public Long getAddressID() {
		return addressID;
	}
	public void setAddressID(Long addressID) {
		this.addressID = addressID;
	}
	public String getCouponNumber() {
		return couponNumber;
	}
	public void setCouponNumber(String couponNumber) {
		this.couponNumber = couponNumber;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Long getOrderTimeStamp() {
		return orderTimeStamp;
	}
	public void setOrderTimeStamp(Long orderTimeStamp) {
		this.orderTimeStamp = orderTimeStamp;
	}
	public Long getPeriodID() {
		return periodID;
	}
	public void setPeriodID(Long periodID) {
		this.periodID = periodID;
	}
	public Double getSendPrice() {
		return sendPrice;
	}
	public void setSendPrice(Double sendPrice) {
		this.sendPrice = sendPrice;
	}
	public String getTimePeriod() {
		return timePeriod;
	}
	public void setTimePeriod(String timePeriod) {
		this.timePeriod = timePeriod;
	}
}

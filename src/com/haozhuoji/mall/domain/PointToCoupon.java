package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;

public class PointToCoupon implements Serializable{
	private static final long serialVersionUID = -8695199230783525024L;
	
	private Long pointToCouponID;
	private Long typeID;
	private Integer points;
	private Double rech;
	private Double sub;
	private Date beginDateTime;
	private Date endDateTime;
	private Long updateTimeStamp;
	
	private String fullTypeName;
	

	public Long getUpdateTimeStamp() {
		return updateTimeStamp;
	}
	public void setUpdateTimeStamp(Long updateTimeStamp) {
		this.updateTimeStamp = updateTimeStamp;
	}
	public String getFullTypeName() {
		return fullTypeName;
	}
	public void setFullTypeName(String fullTypeName) {
		this.fullTypeName = fullTypeName;
	}
	public Long getTypeID() {
		return typeID;
	}
	public void setTypeID(Long typeID) {
		this.typeID = typeID;
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
	public Long getPointToCouponID() {
		return pointToCouponID;
	}
	public void setPointToCouponID(Long pointToCouponID) {
		this.pointToCouponID = pointToCouponID;
	}
	public Integer getPoints() {
		return points;
	}
	public void setPoints(Integer points) {
		this.points = points;
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
}

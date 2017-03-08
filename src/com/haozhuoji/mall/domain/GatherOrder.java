package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class GatherOrder implements Serializable{
	private static final long serialVersionUID = -3188065665942243912L;
	
	private Long id;
	
	private int distributionInfo;
	
	private boolean print=false;
	
	private String distributionTime;
	
	private Date createDateTime = new Date();
	
	private int gatherNumber;
	
	private Set<Order> orders = new HashSet<Order>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getDistributionInfo() {
		return distributionInfo;
	}

	public void setDistributionInfo(int distributionInfo) {
		this.distributionInfo = distributionInfo;
	}
	
	public boolean isPrint() {
		return print;
	}

	public void setPrint(boolean print) {
		this.print = print;
	}

	public String getDistributionTime() {
		return distributionTime;
	}

	public void setDistributionTime(String distributionTime) {
		this.distributionTime = distributionTime;
	}
	
	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getGatherNumber() {
		return gatherNumber;
	}

	public void setGatherNumber(int gatherNumber) {
		this.gatherNumber = gatherNumber;
	}

	public Set<Order> getOrders() {
		return orders;
	}

	public void setOrders(Set<Order> orders) {
		this.orders = orders;
	}
	
	
}

package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;
/**
 * 订单商品列表表对应javabean
 * @author Chen Zhuo
 *
 */
public class OrderGoods implements Serializable{
	private static final long serialVersionUID = -1977309798354670495L;
	
	private Long orderGoodsID;
	
	private Long orderID;
	
	private String goodsIDs;
	
	private Long userID;
	
	private String goodsName;
	
	private Integer amount;
	
	private Date createDateTime;
	
	
	private Double cost_price;
	
	private Double product_price;
	
	private String comment;
	
	private Boolean del;
	private Boolean cancel;
	private Date distributionTime;
	
	public Boolean getDel() {
		return del;
	}

	public void setDel(Boolean del) {
		this.del = del;
	}

	public Boolean getCancel() {
		return cancel;
	}

	public void setCancel(Boolean cancel) {
		this.cancel = cancel;
	}

	public Date getDistributionTime() {
		return distributionTime;
	}

	public void setDistributionTime(Date distributionTime) {
		this.distributionTime = distributionTime;
	}

	public Long getOrderGoodsID() {
		return orderGoodsID;
	}

	public void setOrderGoodsID(Long orderGoodsID) {
		this.orderGoodsID = orderGoodsID;
	}

	public Long getOrderID() {
		return orderID;
	}

	public void setOrderID(Long orderID) {
		this.orderID = orderID;
	}

	public String getGoodsIDs() {
		return goodsIDs;
	}

	public void setGoodsIDs(String goodsIDs) {
		this.goodsIDs = goodsIDs;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}
	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public Double getCost_price() {
		return cost_price;
	}

	public void setCost_price(Double cost_price) {
		this.cost_price = cost_price;
	}

	public Double getProduct_price() {
		return product_price;
	}

	public void setProduct_price(Double product_price) {
		this.product_price = product_price;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
}

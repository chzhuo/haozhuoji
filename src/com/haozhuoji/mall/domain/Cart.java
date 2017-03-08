package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
/**
 * 购物车表对应javabean
 * @author Chen Zhuo
 *
 */
public class Cart implements Serializable{
	private static final long serialVersionUID = 3022538874170006646L;
	
	private Long cartID;
	
	private Long userID;
	
	private Long goodsID;
	
	private Integer count;
	
	private Double price;
	
	private Date createDateTime;
	
	private Date lastModify;
	
	private Integer amount;
	
	private Long bundlingID;
	
	
	//
	private Boolean stock=true;
	private Boolean sell=true;
	public Boolean getSell() {
		return sell;
	}

	public void setSell(Boolean sell) {
		this.sell = sell;
	}

	private Integer points;
	
	public Long getBundlingID() {
		return bundlingID;
	}

	public void setBundlingID(Long bundlingID) {
		this.bundlingID = bundlingID;
	}

	public Integer getPoints() {
		return points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}

	private List<Goods> goodsList;
	
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public List<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	public Boolean getStock() {
		return stock;
	}

	public void setStock(Boolean stock) {
		this.stock = stock;
	}

	public Long getCartID() {
		return cartID;
	}

	public void setCartID(Long cartID) {
		this.cartID = cartID;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public Long getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Long goodsID) {
		this.goodsID = goodsID;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public Date getLastModify() {
		return lastModify;
	}

	public void setLastModify(Date lastModify) {
		this.lastModify = lastModify;
	}
}

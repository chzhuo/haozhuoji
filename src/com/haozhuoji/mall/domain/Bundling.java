package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.List;

public class Bundling implements Serializable{
	private static final long serialVersionUID = -1655190534267298132L;
	
	private Long bundlingID;
	
	private String goodsIDs;
	
	private Double price;
	
	private Integer amount;
	
	private String sentence;
	
	private Integer points;
	//未持久化字段
	private Long goodsID;
	private List<Goods> goodsList;
	
	public List<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	public Long getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Long goodsID) {
		this.goodsID = goodsID;
	}

	public Long getBundlingID() {
		return bundlingID;
	}

	public void setBundlingID(Long bundlingID) {
		this.bundlingID = bundlingID;
	}

	public String getGoodsIDs() {
		return goodsIDs;
	}

	public void setGoodsIDs(String goodsIDs) {
		this.goodsIDs = goodsIDs;
	}

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

	public String getSentence() {
		return sentence;
	}

	public void setSentence(String sentence) {
		this.sentence = sentence;
	}

	public Integer getPoints() {
		return points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}
}

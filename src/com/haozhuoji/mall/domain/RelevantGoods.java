package com.haozhuoji.mall.domain;

import java.io.Serializable;

public class RelevantGoods implements Serializable {
	private static final long serialVersionUID = -1581729589433887313L;
	
	private Long RelevantGoodsID;
	private String goodsIDs;
	private Long notInID;
	
	public Long getNotInID() {
		return notInID;
	}
	public void setNotInID(Long notInID) {
		this.notInID = notInID;
	}
	public Long getRelevantGoodsID() {
		return RelevantGoodsID;
	}
	public void setRelevantGoodsID(Long relevantGoodsID) {
		RelevantGoodsID = relevantGoodsID;
	}
	public String getGoodsIDs() {
		return goodsIDs;
	}
	public void setGoodsIDs(String goodsIDs) {
		this.goodsIDs = goodsIDs;
	}
}

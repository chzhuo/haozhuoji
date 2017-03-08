package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;

public class Collection implements Serializable{
	private static final long serialVersionUID = 2230867767806393336L;
	
	private Long collectionID;
	
	private Long userID;
	
	private Long goodsID;
	
	private Date createDateTime;
	
	//
	private Goods goods;
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Long getCollectionID() {
		return collectionID;
	}

	public void setCollectionID(Long collectionID) {
		this.collectionID = collectionID;
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

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
}

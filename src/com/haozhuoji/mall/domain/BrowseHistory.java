package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;

public class BrowseHistory implements Serializable{
	private static final long serialVersionUID = -2259216791644976401L;
	
	private Long browseHistoryID;
	
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

	public Long getBrowseHistoryID() {
		return browseHistoryID;
	}

	public void setBrowseHistoryID(Long browseHistoryID) {
		this.browseHistoryID = browseHistoryID;
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

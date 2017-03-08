package com.haozhuoji.mall.domain;

import java.util.List;

public class GoodsItem {
	private Long goodsItemID;
	private Long promotionID;
	private String goodsIDs;
	private String itemTitle;
	private String itemImg;
	//
	private List<Goods> goodsList;
	public List<Goods> getGoodsList() {
		return goodsList;
	}
	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}
	public Long getGoodsItemID() {
		return goodsItemID;
	}
	public void setGoodsItemID(Long goodsItemID) {
		this.goodsItemID = goodsItemID;
	}
	public Long getPromotionID() {
		return promotionID;
	}
	public void setPromotionID(Long promotionID) {
		this.promotionID = promotionID;
	}
	public String getGoodsIDs() {
		return goodsIDs;
	}
	public void setGoodsIDs(String goodsIDs) {
		this.goodsIDs = goodsIDs;
	}
	public String getItemTitle() {
		return itemTitle;
	}
	public void setItemTitle(String itemTitle) {
		this.itemTitle = itemTitle;
	}
	public String getItemImg() {
		return itemImg;
	}
	public void setItemImg(String itemImg) {
		this.itemImg = itemImg;
	}
	
}

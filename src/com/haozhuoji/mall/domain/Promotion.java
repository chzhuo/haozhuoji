package com.haozhuoji.mall.domain;

import java.util.Date;
import java.util.List;

public class Promotion {
	private Long promotionID;
	private String title;
	private String titleImg;
	private String cssStyle;
	private Date beginDateTime;
	private Date endDateTime;
	private Boolean updatePrice;
	private Boolean rePrice;
	private String goodsIDs;
	private Boolean upIndex;
	private Boolean upHeader;
	//
	private List<Goods> goodsList;
	public List<Goods> getGoodsList() {
		return goodsList;
	}
	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}
	public Long getPromotionID() {
		return promotionID;
	}
	public void setPromotionID(Long promotionID) {
		this.promotionID = promotionID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTitleImg() {
		return titleImg;
	}
	public void setTitleImg(String titleImg) {
		this.titleImg = titleImg;
	}
	public String getCssStyle() {
		return cssStyle;
	}
	public void setCssStyle(String cssStyle) {
		this.cssStyle = cssStyle;
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
	public Boolean getUpdatePrice() {
		return updatePrice;
	}
	public void setUpdatePrice(Boolean updatePrice) {
		this.updatePrice = updatePrice;
	}
	public Boolean getRePrice() {
		return rePrice;
	}
	public void setRePrice(Boolean rePrice) {
		this.rePrice = rePrice;
	}
	public String getGoodsIDs() {
		return goodsIDs;
	}
	public void setGoodsIDs(String goodsIDs) {
		this.goodsIDs = goodsIDs;
	}
	public Boolean getUpIndex() {
		return upIndex;
	}
	public void setUpIndex(Boolean upIndex) {
		this.upIndex = upIndex;
	}
	public Boolean getUpHeader() {
		return upHeader;
	}
	public void setUpHeader(Boolean upHeader) {
		this.upHeader = upHeader;
	}
}

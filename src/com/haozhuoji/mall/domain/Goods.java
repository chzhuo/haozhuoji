package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
/**
 * 商品表对应的javabean
 * @author Chen Zhuo
 *
 */
public class Goods implements Serializable{
	private static final long serialVersionUID = 7074813194284392045L;
	
	//主键
	private Long goodsID;
	
	//商品名
	private String goodsName;
	
	//商品编号
	private String productNumber;
	
	//商品价格
	private Double product_price;
	
	//参考价格
	private Double reference_price;
	
	//活动价格
	private Double promotion_price;
	
	//成本价格
	private Double cost_price;	
	
	//收藏次数
	private Integer collection_count;
	
	//评论次数
	private Integer comment_count;
	
	//浏览次数
	private Integer browse_count;
	
	//购买次数
	private Integer purchase_count;
	
	//规格
	private String specification;
	
	//促销语
	private String promotion_sentence;
	
	//货架号
	private String shelfNumber;
	
	//上架时间
	private Date createDateTime;
	
	//商品库存
	private Integer amount;
	
	//商品分类
	private Long typeID;
	
	//商品品牌
	private String brand;
	
	//积分
	private Integer points;
	
	//商品搜索关键字
	private String keyWord;
	
	private String properties;
	
	//商品详细描述页面
	private String descriptionPage;
	
	//搜索范围
	private String searchScope;
	
	//最近修改
	private Long updateTimeStamp;
	
	private Boolean sell;
	//===============未持久化到数据库
	private String aveComment;
	private String fullTypeName;
	private String fullTypeID;
	private String typeName;
	public String getAveComment() {
		return aveComment;
	}

	public void setAveComment(String aveComment) {
		this.aveComment = aveComment;
	}

	public Boolean getSell() {
		return sell;
	}

	public void setSell(Boolean sell) {
		this.sell = sell;
	}

	public Long getUpdateTimeStamp() {
		return updateTimeStamp;
	}

	public void setUpdateTimeStamp(Long updateTimeStamp) {
		this.updateTimeStamp = updateTimeStamp;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getFullTypeName() {
		return fullTypeName;
	}

	public void setFullTypeName(String fullTypeName) {
		this.fullTypeName = fullTypeName;
	}

	public String getFullTypeID() {
		return fullTypeID;
	}

	public void setFullTypeID(String fullTypeID) {
		this.fullTypeID = fullTypeID;
	}
	public String getProperties() {
		return properties;
	}

	public void setProperties(String properties) {
		this.properties = properties;
	}
	public String getSearchScope() {
		return searchScope;
	}

	public void setSearchScope(String searchScope) {
		this.searchScope = searchScope;
	}

	public Long getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Long goodsID) {
		this.goodsID = goodsID;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getProductNumber() {
		return productNumber;
	}

	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}

	public Double getProduct_price() {
		return product_price;
	}

	public void setProduct_price(Double product_price) {
		this.product_price = product_price;
	}

	public Double getReference_price() {
		return reference_price;
	}

	public void setReference_price(Double reference_price) {
		this.reference_price = reference_price;
	}

	public Double getPromotion_price() {
		return promotion_price;
	}

	public void setPromotion_price(Double promotion_price) {
		this.promotion_price = promotion_price;
	}

	public Double getCost_price() {
		return cost_price;
	}

	public void setCost_price(Double cost_price) {
		this.cost_price = cost_price;
	}

	public Integer getCollection_count() {
		return collection_count;
	}

	public void setCollection_count(Integer collection_count) {
		this.collection_count = collection_count;
	}

	public Integer getComment_count() {
		return comment_count;
	}

	public void setComment_count(Integer comment_count) {
		this.comment_count = comment_count;
	}

	public Integer getBrowse_count() {
		return browse_count;
	}

	public void setBrowse_count(Integer browse_count) {
		this.browse_count = browse_count;
	}

	public Integer getPurchase_count() {
		return purchase_count;
	}

	public void setPurchase_count(Integer purchase_count) {
		this.purchase_count = purchase_count;
	}

	public String getSpecification() {
		return specification;
	}

	public void setSpecification(String specification) {
		this.specification = specification;
	}

	public String getPromotion_sentence() {
		return promotion_sentence;
	}

	public void setPromotion_sentence(String promotion_sentence) {
		this.promotion_sentence = promotion_sentence;
	}

	public String getShelfNumber() {
		return shelfNumber;
	}

	public void setShelfNumber(String shelfNumber) {
		this.shelfNumber = shelfNumber;
	}
	
	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	
	public Long getTypeID() {
		return typeID;
	}

	public void setTypeID(Long typeID) {
		this.typeID = typeID;
	}
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public Integer getPoints() {
		return points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	public String getDescriptionPage() {
		return descriptionPage;
	}

	public void setDescriptionPage(String descriptionPage) {
		this.descriptionPage = descriptionPage;
	}
}

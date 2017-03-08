package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
/**
 * 订单表对应的javabean
 */
public class Order implements Serializable{
	private static final long serialVersionUID = 5266648302738612125L;
	
	private Long orderID;
	
	private String orderNumber;
	
	private Long userID;
	
	private Double order_price;
	
	private Double goods_price;
	
	private Double activity_price;
	private Double coupon_price;
	private String timePeriod;
	
	private Date distributionTime;
	
	private Date createDateTime;
	
	private String address;
	
	private Double send_price;
	
	private Date printDateTime;
	
	private Integer points;
	
	//订单优惠信息
	private String orderCouponInfo;
	
	//订单系统信息
	private String orderInfo;
	
	//用户遗留信息
	private String leaveMessage;	
	
	
	private Boolean print;
	private Boolean cancel;
	private Boolean del;
	private Boolean comment;
	private Boolean addPoint;

	
	//未持久化
	private Double activitySub;
	private Long couponID;
	private Coupon coupon;
	private List<Cart> cartList;
	private List<Activity> activityList;
	private List<OrderGoods> orderGoodsList;
	private String orderIDs;
	public String getOrderIDs() {
		return orderIDs;
	}

	public void setOrderIDs(String orderIDs) {
		this.orderIDs = orderIDs;
	}

	public Boolean getAddPoint() {
		return addPoint;
	}

	public void setAddPoint(Boolean addPoint) {
		this.addPoint = addPoint;
	}

	public List<OrderGoods> getOrderGoodsList() {
		return orderGoodsList;
	}

	public void setOrderGoodsList(List<OrderGoods> orderGoodsList) {
		this.orderGoodsList = orderGoodsList;
	}

	public Date getPrintDateTime() {
		return printDateTime;
	}

	public void setPrintDateTime(Date printDateTime) {
		this.printDateTime = printDateTime;
	}

	public Double getActivity_price() {
		return activity_price;
	}

	public void setActivity_price(Double activity_price) {
		this.activity_price = activity_price;
	}

	public Double getCoupon_price() {
		return coupon_price;
	}

	public void setCoupon_price(Double coupon_price) {
		this.coupon_price = coupon_price;
	}

	public Boolean getPrint() {
		return print;
	}

	public void setPrint(Boolean print) {
		this.print = print;
	}

	public Boolean getCancel() {
		return cancel;
	}

	public void setCancel(Boolean cancel) {
		this.cancel = cancel;
	}
	public Boolean getDel() {
		return del;
	}

	public void setDel(Boolean del) {
		this.del = del;
	}

	public Boolean getComment() {
		return comment;
	}

	public void setComment(Boolean comment) {
		this.comment = comment;
	}

	public Double getActivitySub() {
		return activitySub;
	}

	public void setActivitySub(Double activitySub) {
		this.activitySub = activitySub;
	}

	public List<Activity> getActivityList() {
		return activityList;
	}

	public void setActivityList(List<Activity> activityList) {
		this.activityList = activityList;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public Long getCouponID() {
		return couponID;
	}

	public void setCouponID(Long couponID) {
		this.couponID = couponID;
	}

	public List<Cart> getCartList() {
		return cartList;
	}

	public void setCartList(List<Cart> cartList) {
		this.cartList = cartList;
	}

	public Long getOrderID() {
		return orderID;
	}

	public void setOrderID(Long orderID) {
		this.orderID = orderID;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public Double getOrder_price() {
		return order_price;
	}

	public void setOrder_price(Double order_price) {
		this.order_price = order_price;
	}

	public Date getDistributionTime() {
		return distributionTime;
	}

	public void setDistributionTime(Date distributionTime) {
		this.distributionTime = distributionTime;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public Double getSend_price() {
		return send_price;
	}

	public void setSend_price(Double send_price) {
		this.send_price = send_price;
	}

	public String getTimePeriod() {
		return timePeriod;
	}

	public void setTimePeriod(String timePeriod) {
		this.timePeriod = timePeriod;
	}

	public Integer getPoints() {
		return points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}
	public String getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
	}

	public String getLeaveMessage() {
		return leaveMessage;
	}

	public void setLeaveMessage(String leaveMessage) {
		this.leaveMessage = leaveMessage;
	}
	public Double getGoods_price() {
		return goods_price;
	}

	public void setGoods_price(Double goods_price) {
		this.goods_price = goods_price;
	}

	public String getOrderCouponInfo() {
		return orderCouponInfo;
	}

	public void setOrderCouponInfo(String orderCouponInfo) {
		this.orderCouponInfo = orderCouponInfo;
	}
}

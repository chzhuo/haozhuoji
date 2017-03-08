package com.haozhuoji.mall.domain;

import java.io.Serializable;
import java.util.Date;
/**
 * 评论表对应的javabean
 * @author Chen Zhuo
 *
 */
public class Comment implements Serializable{
	private static final long serialVersionUID = 8433606404506370934L;

	private Long commentID;
	
	private Long goodsID;
	
	private Long orderID;
	
	private Long userID;
	
	private Date createDateTime;
	
	private Date replyDateTime;
	private String content;
	
	private Integer point;
	private String reply;
	private Boolean showFlag;
	private Boolean delFlag;
	
	private Long orderGoodsID;
	private Integer count;
	private String nickName;
	public String getNickName() {
		return nickName;
	}


	public void setNickName(String nickName) {
		this.nickName = nickName;
	}


	public Integer getCount() {
		return count;
	}


	public void setCount(Integer count) {
		this.count = count;
	}


	public Long getOrderGoodsID() {
		return orderGoodsID;
	}

	
	public Integer getPoint() {
		return point;
	}


	public void setPoint(Integer point) {
		this.point = point;
	}


	public void setOrderGoodsID(Long orderGoodsID) {
		this.orderGoodsID = orderGoodsID;
	}

	public Long getCommentID() {
		return commentID;
	}

	public void setCommentID(Long commentID) {
		this.commentID = commentID;
	}

	public Long getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Long goodsID) {
		this.goodsID = goodsID;
	}

	public Long getOrderID() {
		return orderID;
	}

	public void setOrderID(Long orderID) {
		this.orderID = orderID;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public Boolean getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(Boolean showFlag) {
		this.showFlag = showFlag;
	}

	public Boolean getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Boolean delFlag) {
		this.delFlag = delFlag;
	}

	public Date getReplyDateTime() {
		return replyDateTime;
	}

	public void setReplyDateTime(Date replyDateTime) {
		this.replyDateTime = replyDateTime;
	}
}

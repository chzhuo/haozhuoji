package com.haozhuoji.mall.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Comment;
import com.haozhuoji.mall.domain.OrderGoods;
import com.haozhuoji.mall.service.CommentService;
import com.haozhuoji.mall.service.OrderGoodsService;
import com.haozhuoji.mall.service.OrderService;
import com.haozhuoji.mall.util.Constant;

@Service("commentService")
public class CommentServiceImpl extends BaseServiceImpl<Comment> implements CommentService {
	@Resource(name="orderGoodsService")
	private OrderGoodsService orderGoodsService;
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	@Override
	public String comment(Comment comment) {
		OrderGoods og = new OrderGoods();
		og.setOrderGoodsID(comment.getOrderGoodsID());
		og=orderGoodsService.getObject("OrderGoods.getObject", og);
		if(og==null){
			return "不存在该记录";
		}else if(og.getCancel()){
			return "该订单已经被取消";
		}else if(og.getDistributionTime().getTime()+Constant.orderDelayed>System.currentTimeMillis()){
			return "该订单暂未配送完毕";
		}else if(og.getComment().contains("-"+comment.getGoodsID()+"-")){
			return "该订单商品已经被评论";
		}
		comment.setOrderID(og.getOrderID());
		comment.setShowFlag(true);
		comment.setDelFlag(false);
		this.insert("Comment.add", comment);
		
		OrderGoods og1 = new OrderGoods();
		og1.setOrderGoodsID(comment.getOrderGoodsID());
		og1.setComment(og.getComment()+"-"+comment.getGoodsID()+"-");
		orderGoodsService.update("OrderGoods.update", og1);
		
		//检测是否定否评论完毕
		orderService.checkComment(og.getOrderID());
		return null;
	}
	
}

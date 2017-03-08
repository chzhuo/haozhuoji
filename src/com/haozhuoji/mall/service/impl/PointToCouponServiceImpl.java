package com.haozhuoji.mall.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Coupon;
import com.haozhuoji.mall.domain.PointToCoupon;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.CouponService;
import com.haozhuoji.mall.service.PointToCouponService;
import com.haozhuoji.mall.service.UserService;

@Service("pointToCouponService")
public class PointToCouponServiceImpl extends BaseServiceImpl<PointToCoupon> implements PointToCouponService{
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="couponService")
	private CouponService couponService;
	
	@Override
	public String exchange(PointToCoupon ptc, User user) {
		PointToCoupon p = dao.getObject("PointToCoupon.getObject", ptc);
		if(p==null){
			return "不存在该兑换规则，请刷新后再试！";
		}else if(p.getEndDateTime().getTime()<System.currentTimeMillis()){
			return "该兑换规则已经过期，请刷新后再试！";
		}else if(!p.getUpdateTimeStamp().equals(ptc.getUpdateTimeStamp())){
			return "该兑换规则已经被更新，请刷新后再试！";
		}
		User u = userService.getObject("User.getObject", user);
		if(u.getPoints()<p.getPoints()){
			return "对不起，您的积分不足！";
		}else{
			Coupon coupon = new Coupon();
			coupon.setBindUserID(user.getUserID());
			coupon.setIssue(true);
			coupon.setTypeID(p.getTypeID());
			coupon.setRech(p.getRech());
			coupon.setSub(p.getSub());
			coupon.setBeginDateTime(p.getBeginDateTime());
			coupon.setEndDateTime(p.getEndDateTime());
			coupon.setUsed(false);
			couponService.insert(coupon);
			coupon.setBindUserID(u.getUserID());
			
			u = new User();
			u.setUserID(user.getUserID());
			u.setPoints(-p.getPoints());
			userService.update("User.update", u);
			userService.updateUserBean();
		}
		return "success";
	}
}

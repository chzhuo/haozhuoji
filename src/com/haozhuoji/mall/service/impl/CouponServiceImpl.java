package com.haozhuoji.mall.service.impl;

import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Coupon;
import com.haozhuoji.mall.service.CouponService;

@Service("couponService")
public class CouponServiceImpl extends BaseServiceImpl<Coupon> implements CouponService{

	@Override
	public void insert(Coupon coupon) {
		coupon.setCouponNumber(this.generateNumber());
		this.insert("Coupon.add",coupon);
	}
	
	private String generateNumber(){
		for(int j=0;j<1000;j++){
			String s = "ABCDEFGHIGKLMNPQRSTUVWXYZ123456789";
			Random r = new Random();
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<10;i++){
				sb.append(s.charAt(r.nextInt(s.length())));
			}
			Coupon c = new Coupon();
			c.setCouponNumber(sb.toString());
			Coupon c1 = dao.getObject("Coupon.getObject", c);
			if(c1==null){
				return sb.toString();
			}
		}
		throw new RuntimeException("循环1000次，未找到合适");
	}

	@Override
	public Coupon getAbleCouponSingle(Long userID, String couponNumber) {
		Coupon c = new Coupon();
		c.setBindUserID(userID);
		c.setCouponNumber(couponNumber);
		List<Coupon> clist = dao.getList("Coupon.getAbleCoupon", c);
		if(clist.size()==0||clist.size()>1){
			return null;
		}else{
			return clist.get(0);
		}
	}

	@Override
	public List<Coupon> getAbleCoupon(Long userID) {
		Coupon c = new Coupon();
		c.setBindUserID(userID);
		return dao.getList("Coupon.getAbleCoupon", c);
	}

	@Override
	public Coupon getNewCoupon(String couponNumber) {
		Coupon c = new Coupon();
		c.setCouponNumber(couponNumber);
		return dao.getObject("Coupon.getNewCoupon", c);
	}
}

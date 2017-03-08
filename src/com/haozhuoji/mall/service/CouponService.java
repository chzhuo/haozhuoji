package com.haozhuoji.mall.service;

import java.util.List;

import com.haozhuoji.mall.domain.Coupon;


public interface CouponService extends BaseService<Coupon> {
	public void insert(Coupon coupon);

	public Coupon getAbleCouponSingle(Long userID, String couponNumber);

	public List<Coupon> getAbleCoupon(Long userID);

	public Coupon getNewCoupon(String couponNumber);
}

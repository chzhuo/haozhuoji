package com.haozhuoji.mall.service;

import com.haozhuoji.mall.domain.PointToCoupon;
import com.haozhuoji.mall.domain.User;

public interface PointToCouponService extends BaseService<PointToCoupon> {

	public String exchange(PointToCoupon ptc, User user);
}

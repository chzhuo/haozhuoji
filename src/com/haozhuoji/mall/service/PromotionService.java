package com.haozhuoji.mall.service;

import com.haozhuoji.mall.domain.Promotion;

public interface PromotionService extends BaseService<Promotion> {
	public void delete(Promotion p);

	public void update(Promotion p) throws Exception;
}

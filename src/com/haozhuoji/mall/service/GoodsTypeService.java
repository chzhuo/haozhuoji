package com.haozhuoji.mall.service;

import java.util.List;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.GoodsType;

public interface GoodsTypeService extends BaseService<GoodsType> {

	public List<GoodsType> getAllGoodsType();
	public List<GoodsType> getTypeByGoods(Goods goods);
}

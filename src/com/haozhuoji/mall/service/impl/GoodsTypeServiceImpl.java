package com.haozhuoji.mall.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.service.GoodsTypeService;

@Service("goodsTypeService")
public class GoodsTypeServiceImpl extends BaseServiceImpl<GoodsType> implements GoodsTypeService{
	
	@Override
	public List<GoodsType> getAllGoodsType(){
		return this.getList("GoodsType.getList",new GoodsType());
	}
	
	public List<GoodsType> getTypeByGoods(Goods goods){
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Goods", goods);
		return dao.getListHashMap("GoodsType.getTypeByGoods", hashMap);
	}
}

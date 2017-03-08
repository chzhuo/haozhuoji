package com.haozhuoji.mall.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Bundling;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.service.BundlingService;
import com.haozhuoji.mall.service.GoodsService;

@Service("bundlingService")
public class BundlingServiceImpl extends BaseServiceImpl<Bundling> implements BundlingService{
	
	@Resource(name="goodsService")
	private GoodsService goodsService;

	@Override
	public String checkGoodsIDs(Bundling bundling) {
		//检测是否存在该商品
		Goods g = new Goods();
		for(String goodsID:bundling.getGoodsIDs().split("-")){
			g.setGoodsID(Long.parseLong(goodsID));
			if(goodsService.getObject("Goods.getObject", g)==null){
				return goodsID;
			}
		}
		return null;
	}
}

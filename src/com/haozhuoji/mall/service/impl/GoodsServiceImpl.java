package com.haozhuoji.mall.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.service.GoodsService;

@Service("goodsService")
public class GoodsServiceImpl extends BaseServiceImpl<Goods> implements GoodsService{
	
	@Override
	public List<Goods> search(Goods goods,Page page) throws Exception{
		goods.setSell(true);
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Goods", goods);
		hashMap.put("Page", page);
		return this.getListHashMap("Goods.getSearchListAdmin",hashMap);
	}
	
	@Override
	public Page page(Goods goods,Page page) throws Exception{
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Goods", goods);
		int count = this.getIntHashMap("Goods.getSearchPage",hashMap);
		page.setTotalOption(count);
		return page;
	}

	@Override
	public List<Goods> adminSearch(Goods model, Page page) {
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Goods", model);
		hashMap.put("Page", page);
		return this.getListHashMap("Goods.getSearchListAdmin",hashMap);
	}
}

package com.haozhuoji.mall.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Collection;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.service.CollectionService;
import com.haozhuoji.mall.service.GoodsService;

@Service("collectionService")
public class CollectionServiceImpl extends BaseServiceImpl<Collection> implements CollectionService{
	@Resource(name="goodsService")
	private GoodsService gs;
	@Override
	public void insert(Collection c) {
		Collection c1 = dao.getObject("Collection.getObject", c);
		if(c1==null){
			dao.insert("Collection.add", c);
			Goods g= new Goods();
			g.setGoodsID(c.getGoodsID());
			g.setCollection_count(1);
			//增加商品收藏次数
			gs.update("Goods.update", g);
		}
	}
}

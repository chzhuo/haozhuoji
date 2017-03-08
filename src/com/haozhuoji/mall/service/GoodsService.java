package com.haozhuoji.mall.service;

import java.util.List;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.Page;

public interface GoodsService extends BaseService<Goods>{

	public List<Goods> search(Goods goods,Page page) throws Exception;

	Page page(Goods goods, Page page) throws Exception;

	public List<Goods> adminSearch(Goods model, Page page);
}

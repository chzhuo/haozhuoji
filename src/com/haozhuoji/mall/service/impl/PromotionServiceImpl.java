package com.haozhuoji.mall.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.GoodsItem;
import com.haozhuoji.mall.domain.Promotion;
import com.haozhuoji.mall.service.GoodsItemService;
import com.haozhuoji.mall.service.PromotionService;

@Service("promotionService")
public class PromotionServiceImpl extends BaseServiceImpl<Promotion> implements PromotionService{
	@Resource(name="goodsItemService")
	private GoodsItemService goodsItemService;
	
	public void delete(Promotion p){
		GoodsItem gi = new GoodsItem();
		gi.setPromotionID(p.getPromotionID());
		goodsItemService.delete("GoodsItem.delete", gi);
		this.delete("Promotion.delete",p);
	}
	
	public void update(Promotion p) throws Exception{
		Promotion p1 = this.getObject("Promotion.getList", p);
		
		//修改商品ids和活动开始时间
		if(p.getGoodsIDs()!=null&&!p1.getGoodsIDs().equals(p.getGoodsIDs())&&p1.getUpdatePrice()){			
			throw new Exception("该活动已经开始，不能修改商品IDs,活动开始时间!");
		}
		if(p.getBeginDateTime()!=null&&p1.getBeginDateTime().getTime()!=p.getBeginDateTime().getTime()&&p1.getUpdatePrice()){			
			throw new Exception("该活动已经开始，不能修改商品IDs,活动开始时间!");
		}
		this.update("Promotion.update",p);
	}
}

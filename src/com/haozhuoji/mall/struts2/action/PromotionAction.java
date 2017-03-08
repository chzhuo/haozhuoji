package com.haozhuoji.mall.struts2.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.GoodsItem;
import com.haozhuoji.mall.domain.Promotion;
import com.haozhuoji.mall.service.GoodsItemService;
import com.haozhuoji.mall.service.PromotionService;


@Controller("promotionAction")
@Scope("prototype")
public class PromotionAction extends BaseAction<Promotion> {
	@Resource(name="promotionService")
	private PromotionService promotionService;
	
	@Resource(name="goodsItemService")
	private GoodsItemService goodsItemService;
	public String promotion(){
		if(model.getPromotionID()!=null){
			Promotion p = new Promotion();
			p.setPromotionID(model.getPromotionID());
			model =  promotionService.getObject("Promotion.getPromotionByID", p);
			GoodsItem gi = new GoodsItem();
			gi.setPromotionID(model.getPromotionID());
			request.setAttribute("goodsItemList", goodsItemService.getList("GoodsItem.getByPromotionID", gi));
			
		}
		return "promotion";
	}
}

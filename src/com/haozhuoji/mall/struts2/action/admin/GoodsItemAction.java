package com.haozhuoji.mall.struts2.action.admin;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.GoodsItem;
import com.haozhuoji.mall.service.GoodsItemService;
import com.haozhuoji.mall.service.PromotionService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("goodsItemAction")
@Scope("prototype")
public class GoodsItemAction extends BaseAction<GoodsItem>{
	@Resource(name="promotionService")
	private PromotionService promotionService;

	@Resource(name="goodsItemService")
	private GoodsItemService goodsItemService;
	
	
	
	//删除goodsItem
	public void deleteGoodsItem(){
		if(model.getGoodsItemID()==null){
			flushJson("{status:'参数错误'}");
		}else{			
			GoodsItem g = new GoodsItem();
			g.setGoodsItemID(model.getGoodsItemID());
			goodsItemService.delete("GoodsItem.delete", g);
			flushJson("{status:'success'}");
		}
	}
	
	public void add(){
		if(model.getPromotionID()==null){
			flushJson("{status:'促销ID不能为空'}");
		}else if(model.getGoodsIDs()==null){
			flushJson("{status:'商品IDs不能为空'}");
		}else if(model.getItemImg()==null){
			flushJson("{status:'标题不能为空'}");			
		}else if(!model.getGoodsIDs().matches("\\d+(-\\d+)*")){
			flushJson("{status:'商品IDs格式错误'}");			
		}else{
			GoodsItem gi = new GoodsItem();
			BeanUtils.copyProperties(model, gi);
			goodsItemService.insert("GoodsItem.add", gi);
			flushJson("{status:'success'}");			
		}
	}
	
	public void update(){
		if(model.getGoodsItemID()==null){
			flushJson("{status:'参数错误'}");
		}else {
			if(model.getGoodsIDs()!=null){
				if(!model.getGoodsIDs().matches("\\d+(-\\d+)*")){
					flushJson("{status:'商品IDs格式错误'}");
					return;
				}
			}
			
			GoodsItem gi = new GoodsItem();
			BeanUtils.copyProperties(model, gi);
			goodsItemService.insert("GoodsItem.add", gi);
			flushJson("{status:'success'}");	
		}
	}
}

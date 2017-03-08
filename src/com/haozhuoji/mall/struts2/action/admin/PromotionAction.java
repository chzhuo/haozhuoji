package com.haozhuoji.mall.struts2.action.admin;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.GoodsItem;
import com.haozhuoji.mall.domain.Promotion;
import com.haozhuoji.mall.service.GoodsItemService;
import com.haozhuoji.mall.service.PromotionService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("adminPromotionAction")
@Scope("prototype")
public class PromotionAction extends BaseAction<Promotion>{
	@Resource(name="promotionService")
	private PromotionService promotionService;

	@Resource(name="goodsItemService")
	private GoodsItemService goodsItemService;
	
	
	public String promotionList(){
		request.setAttribute("promotionList", promotionService.getList("Promotion.getAll", new Promotion())); 
		return "promotionList";
	}
	
	//删除promotion
	public void delete(){
		if(model.getPromotionID()==null){
			flushJson("{status:'参数错误'}");
		}else{			
			Promotion p = new Promotion();
			p.setPromotionID(model.getPromotionID());
			Promotion p1 = promotionService.getObject("Promotion.getList", p);
			if(p1.getUpdatePrice()!=p1.getRePrice()){
				flushJson("{status:'该活动还未停止，请先停止活动'}");
			}else{
				promotionService.delete(p);
				flushJson("{status:'success'}");
			}
		}
	}
	
	//跟新
	public void update(){
		if(model.getPromotionID()==null){
			flushJson("{status:'参数错误'}");
		}else{			
			if(model.getGoodsIDs()!=null){
				if(!model.getGoodsIDs().matches("\\d+(-\\d+)*")){
					flushJson("{status:'商品IDs格式错误'}");
					return;
				}
			}
			Promotion p = new Promotion();
			BeanUtils.copyProperties(model, p);
			try {
				promotionService.update(p);
			} catch (Exception e) {
				
				flushJson("{status:'"+e.getLocalizedMessage()+"'}");
			}
			flushJson("{status:'success'}");
		}
	}
	
	//增加
	public void add(){
		if(model.getTitle()==null){
			flushJson("{status:'活动名不能为空'}");
		}else if(model.getTitleImg()==null){
			flushJson("{status:'活动标题图片不能为空'}");			
		}else if(model.getBeginDateTime()==null){
			flushJson("{status:'活动开始时间不能为空'}");						
		}else if(model.getEndDateTime()==null){
			flushJson("{status:'活动结束时间不能为空'}");									
		}else if(model.getGoodsIDs()==null){
			flushJson("{status:'活动商品GoodsID不能为空'}");												
		}else if(!model.getGoodsIDs().matches("\\d+(-\\d+)*")){
			flushJson("{status:'活动商品GoodsID格式错误'}");															
		}else if (model.getUpHeader()==null) {
			flushJson("{status:'活动商品是否推送到头部为空'}");																		
		}else if (model.getUpIndex()==null) {
			flushJson("{status:'活动商品是否推送到主页为空'}");																		
		}else{
			Promotion p = new Promotion();
			BeanUtils.copyProperties(model, p);
			promotionService.insert("Promotion.add", p);
			flushJson("{status:'success'}");
		}
	}
}

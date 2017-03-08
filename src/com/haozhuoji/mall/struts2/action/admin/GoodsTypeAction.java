package com.haozhuoji.mall.struts2.action.admin;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("goodsTypeAction")
@Scope("prototype")
public class GoodsTypeAction extends BaseAction<GoodsType>{
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	public String goodsType(){
		List<GoodsType> goodsTypeList = goodsTypeService.getList("GoodsType.getList", model);
		goodsTypeList.remove(0);
		request.setAttribute("goodsTypeList", goodsTypeList);
		return "goodsType";
	}
	/**
	 * 增加绑定商品
	 * @return
	 */
	public void add(){
		if(!checkFileds()){
			return;
		}
		GoodsType goodsType = new GoodsType();
		BeanUtils.copyProperties(model, goodsType);
		goodsTypeService.insert("GoodsType.add", goodsType);
		flushJson("success");
	}
	
	public void delete(){
		if(model.getTypeID()==null){
			flushJson("类型ID不能为空！");
			return;
		}else{
			Goods g= new Goods();
			g.setTypeID(model.getTypeID());
			HashMap<String,Object> hashMap = new HashMap<String,Object>();
			hashMap.put("Goods", g);
			if(goodsService.getIntHashMap("Goods.getSearchPage", hashMap)>0){
				flushJson("该类型下还有商品，请先改变商品类型！");
				return;
			}
			if(model.getFatherID()==null){
				GoodsType gt = new GoodsType();
				gt.setFatherID(model.getTypeID());
				if(goodsTypeService.getList("GoodsType.getList", gt).size()>0){
					flushJson("该类型下还有子类，请先删除子类！");
					return;					
				}
			}
			GoodsType goodsType = new GoodsType();
			BeanUtils.copyProperties(model, goodsType);
			goodsTypeService.delete("GoodsType.delete", goodsType);
			flushJson("success");
		}
	}
	
	public void update(){
		if(!checkFileds()){
			return;
		}else if(model.getTypeID()==null){
			flushJson("类型ID不能为空");
			return;
		}
		GoodsType goodsType = new GoodsType();
		BeanUtils.copyProperties(model, goodsType);
		goodsTypeService.update("GoodsType.update", goodsType);
		flushJson("success");
	}
	
	private boolean checkFileds(){
		if(!ValidateUtil.validateString(model.getTypeName())){
			flushJson("商品IDs不能为空！");
			return false;
		}
		return true;
	}
}

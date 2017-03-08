package com.haozhuoji.mall.struts2.action.admin;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.RelevantGoods;
import com.haozhuoji.mall.service.RelevantGoodsService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("relevantGoodsAction")
@Scope("prototype")
public class RelevantGoodsAction extends BaseAction<RelevantGoods>{
	@Resource(name="relevantGoodsService")
	private RelevantGoodsService relevantGoodsService;
	
	public String relevantGoods(){
		List<RelevantGoods> relevantGoodsList = relevantGoodsService.getList("RelevantGoods.getAllRelevantGoods", model);
		request.setAttribute("relevantGoodsList", relevantGoodsList);
		return "relevantGoods";
	}
	/**
	 * 增加商品关联
	 * @return
	 */
	public void add(){
		if(!ValidateUtil.validateString(model.getGoodsIDs())){
			flushJson("商品IDs不能为空！");
		}
		if(!model.getGoodsIDs().matches("(\\d+-)+\\d+")){
			flushJson("商品IDs格式错误");
		}
		RelevantGoods rg = new RelevantGoods();
		BeanUtils.copyProperties(model, rg);
		String ret = relevantGoodsService.checkGoodsIDs(rg);
		if(ret==null){
			relevantGoodsService.insert("RelevantGoods.add", rg);
			flushJson("success");
		}else if(ret.startsWith("re")){
			flushJson("ID为 "+ret.replaceAll("re(.+)", "$1")+" 的商品重复 ！");
		}else if(ret.startsWith("-")){
			flushJson("ID为 "+ret.replaceAll("-(.+)", "$1")+" 的商品不存在 ！");
		}else{
			flushJson("ID为 "+ret+" 的商品已存在关联 ！");
		}
	}
	
	public void delete(){
		if(model.getRelevantGoodsID()==null){
			flushJson("商品ID不能为空！");
		}else{
			RelevantGoods rg = new RelevantGoods();
			BeanUtils.copyProperties(model, rg);
			relevantGoodsService.delete("RelevantGoods.delete", rg);
			flushJson("success");
		}
	}
	
	public void update(){
		if(model.getRelevantGoodsID()==null){
			flushJson("商品ID不能为空！");
		}else{
			RelevantGoods rg = new RelevantGoods();
			rg.setNotInID(model.getRelevantGoodsID());
			rg.setGoodsIDs(model.getGoodsIDs());
			String ret = relevantGoodsService.checkGoodsIDs(rg);
			if(ret==null){
				rg = new RelevantGoods();
				BeanUtils.copyProperties(model, rg);
				relevantGoodsService.update("RelevantGoods.update", rg);
				flushJson("success");
			}else if(ret.startsWith("re")){
				flushJson("ID为 "+ret.replaceAll("re(.+)", "$1")+" 的商品重复 ！");
			}else if(ret.startsWith("-")){
				flushJson("ID为 "+ret.replaceAll("-(.+)", "$1")+" 的商品不存在 ！");
			}else{
				flushJson("ID为 "+ret+" 的商品已存在关联 ！");
			}
		}
	}
}

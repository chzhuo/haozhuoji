package com.haozhuoji.mall.struts2.action.admin;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Bundling;
import com.haozhuoji.mall.service.BundlingService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("bundlingAction")
@Scope("prototype")
public class BundlingAction extends BaseAction<Bundling>{
	@Resource(name="bundlingService")
	private BundlingService bundlingService;
	
	public String bundling(){
		List<Bundling> bundlingList = bundlingService.getList("Bundling.getAllBundling", model);
		request.setAttribute("bundlingList", bundlingList);
		return "bundling";
	}
	/**
	 * 增加绑定商品
	 * @return
	 */
	public void add(){
		if(!checkFileds()){
			return;
		}
		Bundling bundling = new Bundling();
		BeanUtils.copyProperties(model, bundling);
		String ret = bundlingService.checkGoodsIDs(bundling);
		if(ret==null){
			bundlingService.insert("Bundling.add", bundling);
			flushJson("success");
		}else{
			flushJson("ID为 "+ret+" 的商品不存在 ！");
		}
	}
	
	public void delete(){
		if(model.getBundlingID()==null){
			flushJson("套餐ID不能为空！");
		}else{
			Bundling bundling = new Bundling();
			BeanUtils.copyProperties(model, bundling);
			bundlingService.delete("Bundling.delete", bundling);
			flushJson("success");
		}
	}
	
	public void update(){
		if(!checkFileds()){
			return;
		}
		Bundling bundling = new Bundling();
		BeanUtils.copyProperties(model, bundling);
		String ret = bundlingService.checkGoodsIDs(bundling);
		if(ret==null){
			bundling = new Bundling();
			BeanUtils.copyProperties(model, bundling);
			bundlingService.update("Bundling.update", bundling);
			flushJson("success");
		}else{
			flushJson("ID为 "+ret+" 的商品不存在 ！");
		}
	}
	
	private boolean checkFileds(){
		String goodsIDs = model.getGoodsIDs();
		Integer amount = model.getAmount();
		Double price = model.getPrice();
		Integer points = model.getPoints();
		if(!ValidateUtil.validateString(goodsIDs)){
			flushJson("商品IDs不能为空！");
			return false;
		}else if(price==null){
			flushJson("价格不能为空！");
			return false;
		}else if(amount==null){
			flushJson("数量不能为空！");
			return false;
		}else if(points==null){
			flushJson("积分不能为空！");
			return false;
		}else if(!goodsIDs.matches("(\\d+-)+\\d+")){
			flushJson("商品IDs格式错误！");
			return false;
		}else{
			String[] s = goodsIDs.split("-");
			for(int i=0;i<s.length-1;i++){
				for(int j=i+1;j<s.length;j++){
					if(s[i]==s[j]){
						flushJson("ID为 "+s[i]+" 的商品重复");
						return false;
					}
				}
			}
		}
		return true;
	}
}

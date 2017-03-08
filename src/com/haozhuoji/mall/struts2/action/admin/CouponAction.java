package com.haozhuoji.mall.struts2.action.admin;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Coupon;
import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.service.CouponService;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("couponAction")
@Scope("prototype")
public class CouponAction extends BaseAction<Coupon>{
	@Resource(name="couponService")
	private CouponService couponService;
	
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	private Page page = new Page();
	
	public String couponList(){
		Coupon c = new Coupon();
		BeanUtils.copyProperties(model, c);
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Coupon", c);
		hashMap.put("Page", page);
		page.setOptionOfPage(50);
		
		page.setTotalOption(couponService.getIntHashMap("Coupon.getPageCount", hashMap));
		
		List<Coupon> couponList = couponService.getListHashMap("Coupon.getListPage", hashMap);
		request.setAttribute("couponList", couponList);
		List<GoodsType> gy = goodsTypeService.getAllGoodsType();
		request.setAttribute("goodsTypeList", gy);
		return "couponList";
	}
	
	public void add(){
		if(!checkFileds()){
			return;
		}
		if(model.getCreateCount()==null){
			flushJson("创建数不能为空");
			return;
		}
		if(model.getCreateCount()<1){
			flushJson("创建数必须大于0");
			return;
		}
		Coupon coupon = new Coupon();
		BeanUtils.copyProperties(model, coupon);
		coupon.setIssue(true);
		coupon.setUsed(false);
		for(int i=0;i<model.getCreateCount();i++){
			couponService.insert(coupon);
		}
		flushJson("success");
	}
	
	public void delete(){
		if(model.getCouponID()==null){
			flushJson("ID不能为空！");
		}else{
			Coupon coupon = new Coupon();
			BeanUtils.copyProperties(model, coupon);
			couponService.delete("Coupon.delete", coupon);
			flushJson("success");
		}
	}
	
	public void update(){
		if(model.getCouponID()==null){
			flushJson("ID不能为空！");
			return;
		}
		if(!checkFileds()){
			return;
		}
		Coupon coupon = new Coupon();
		BeanUtils.copyProperties(model, coupon);
		couponService.update("Coupon.adminUpdate", coupon);
		flushJson("success");
	}
	
	private boolean checkFileds(){
		if(model.getBeginDateTime()==null){
			flushJson("起始时间不能为空！");
			return false;
		}else if(model.getEndDateTime()==null){
			flushJson("结束时间不能为空！");
			return false;
		}else if(model.getTypeID()==null){
			flushJson("商品类型不能为空！");
			return false;
		}else if(model.getRech()==null){
			flushJson("满多少不能为空！");
			return false;
		}else if(model.getSub()  ==null){
			flushJson("减多少不能为空！");
			return false;
		}
		return true;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
}

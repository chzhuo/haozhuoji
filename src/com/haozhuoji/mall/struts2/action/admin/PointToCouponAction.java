package com.haozhuoji.mall.struts2.action.admin;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.domain.PointToCoupon;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.service.PointToCouponService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("pointToCouponAction")
@Scope("prototype")
public class PointToCouponAction extends BaseAction<PointToCoupon>{
	@Resource(name="pointToCouponService")
	private PointToCouponService pointToCouponService;
	
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	public String pointToCoupon(){
		List<PointToCoupon> pointToCouponList = pointToCouponService.getList("PointToCoupon.admin_getAllPointToCoupon", model);
		request.setAttribute("pointToCouponList", pointToCouponList);
		List<GoodsType> gy = goodsTypeService.getAllGoodsType();
		GoodsType g = new GoodsType();
		request.setAttribute("goodsTypeList", gy);
		return "pointToCoupon";
	}
	/**
	 * 增加绑定商品
	 * @return
	 */
	public void add(){
		if(!checkFileds()){
			return;
		}
		PointToCoupon pointToCoupon = new PointToCoupon();
		BeanUtils.copyProperties(model, pointToCoupon);
		pointToCoupon.setUpdateTimeStamp(System.currentTimeMillis());
		pointToCouponService.update("PointToCoupon.add", pointToCoupon);
		flushJson("success");
	}
	
	public void delete(){
		if(model.getPointToCouponID()==null){
			flushJson("ID不能为空！");
		}else{
			PointToCoupon pointToCoupon = new PointToCoupon();
			BeanUtils.copyProperties(model, pointToCoupon);
			pointToCouponService.delete("PointToCoupon.delete", pointToCoupon);
			flushJson("success");
		}
	}
	
	public void update(){
		if(model.getPointToCouponID()==null){
			flushJson("ID不能为空！");
			return;
		}
		if(!checkFileds()){
			return;
		}
		PointToCoupon pointToCoupon = new PointToCoupon();
		BeanUtils.copyProperties(model, pointToCoupon);
		pointToCoupon.setUpdateTimeStamp(System.currentTimeMillis());
		pointToCouponService.update("PointToCoupon.update", pointToCoupon);
		flushJson("success");
	}
	
	private boolean checkFileds(){
		if(model.getPoints()==null){
			flushJson("积分不能为空！");
			return false;
		}else if(model.getBeginDateTime()==null){
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
}

package com.haozhuoji.mall.struts2.action.admin;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.domain.Activity;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.service.ActivityService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("activityAction")
@Scope("prototype")
public class ActivityAction extends BaseAction<Activity>{
	@Resource(name="activityService")
	private ActivityService activityService;
	
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	public String activityList(){
		List<Activity> activityList = activityService.getList("Activity.getList", model);
		request.setAttribute("activityList", activityList);
		List<GoodsType> gy = goodsTypeService.getAllGoodsType();
		request.setAttribute("goodsTypeList", gy);
		return "activityList";
	}
	/**
	 * 增加绑定商品
	 * @return
	 */
	public void add(){
		if(!checkFileds()){
			return;
		}
		Activity activity = new Activity();
		BeanUtils.copyProperties(model, activity);
		if(!activityService.checkTypeID(activity)){
			flushJson("该类的父类已经有活动");
			return;
		}
		activityService.update("Activity.add", activity);
		flushJson("success");
	}
	
	public void delete(){
		if(model.getActivityID()==null){
			flushJson("ID不能为空！");
		}else{
			Activity activity = new Activity();
			BeanUtils.copyProperties(model, activity);
			activityService.delete("Activity.delete", activity);
			flushJson("success");
		}
	}
	
	public void update(){
		if(model.getActivityID()==null){
			flushJson("ID不能为空！");
			return;
		}
		if(!checkFileds()){
			return;
		}
		Activity activity = new Activity();
		BeanUtils.copyProperties(model, activity);
		if(!activityService.checkTypeID(activity)){
			flushJson("该类的父类已经有活动");
			return;
		}
		activityService.update("Activity.update", activity);
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
}

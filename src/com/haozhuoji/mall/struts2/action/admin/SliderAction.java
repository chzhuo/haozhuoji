package com.haozhuoji.mall.struts2.action.admin;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Slider;
import com.haozhuoji.mall.service.SliderService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("sliderAction")
@Scope("prototype")
public class SliderAction extends BaseAction<Slider>{
	@Resource(name="sliderService")
	private SliderService sliderService;
	
	public String sliderList(){
		request.setAttribute("sliderList", sliderService.getList("Slider.getAll", null));
		return "sliderList";
	}
	
	public void add(){
		Slider s = new Slider();
		BeanUtils.copyProperties(model, s);
		flushJson("{status:'success'}");
		sliderService.insert("Slider.add",s);
	}
	
	public void changeImg() throws Exception{
		if(model.getUpload()==null||model.getUploadFileName()==null||model.getSliderID()==null){
			flushJson("{status:'参数异常'}");
		}else{
			Slider s = new Slider();
			BeanUtils.copyProperties(model, s);
			sliderService.changeImg(s);
			flushJson("{status:'success'}");
		}
	}
	public void delete() throws Exception{
		if(model.getSliderID()==null){
			flushJson("{status:'参数异常'}");
		}else{
			Slider s = new Slider();
			BeanUtils.copyProperties(model, s);
			sliderService.delete(s);
			flushJson("{status:'success'}");
		}
	}
	
	public void update (){
		if(model.getSliderID()==null){
			flushJson("{status:'参数异常'}");
		}else{
			Slider s = new Slider();
			BeanUtils.copyProperties(model, s);
			sliderService.update("Slider.update", s);
			flushJson("{status:'success'}");
		}
	}
}

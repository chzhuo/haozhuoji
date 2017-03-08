package com.haozhuoji.mall.struts2.action.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Period;
import com.haozhuoji.mall.service.PeriodService;
import com.haozhuoji.mall.struts2.action.BaseAction;


@Controller("adminPeriodAction")
@Scope("prototype")
public class PeriodAction extends BaseAction<Period> {
	@Resource(name="periodService")
	private PeriodService periodService;
	
	public String periodList(){
		request.setAttribute("periodList", periodService.getList("Period.getAllPeriod", new Period()));
		return "periodList";
	}
	
	public void update(){
		if(model.getPeriodID()==null){
			flushJson("{status:'参数错误'}");
		}else{
			Period p = new Period();
			BeanUtils.copyProperties(model, p);
			periodService.update("Period.update", p);
			flushJson("{status:'success'}");
		}
	}
	
	public void delete(){
		if(model.getPeriodID()==null){
			flushJson("{status:'参数错误'}");
		}else{
			Period p = new Period();
			BeanUtils.copyProperties(model, p);
			periodService.delete("Period.delete", p);
			flushJson("{status:'success'}");
		}
	}
	
	public void add(){
		if(model.getTime()==null){
			flushJson("{status:'截止时间不能为空'}");
		}else if(model.getTimePeriod()==null){
			flushJson("{status:'时段不能为空'}");
		}else if(model.getWeekday()==null){
			flushJson("{status:'周不能为空'}");
		}else if(model.getPrintTime()==null){
			flushJson("{status:'打印时间不能为空'}");
		}else if(model.getAheadOfDay()==null){
			flushJson("{status:'打印提前天数不能为空'}");
		}else{
			Period p = new Period();
			BeanUtils.copyProperties(model, p);
			periodService.insert("Period.add", p);
			flushJson("{status:'success'}");
		}
	}
}

package com.haozhuoji.mall.struts2.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Period;
import com.haozhuoji.mall.service.PeriodService;


@Controller("periodAction")
@Scope("prototype")
public class PeriodAction extends BaseAction<Period> {
	@Resource(name="periodService")
	
	private PeriodService periodService;
	public void getNextPeriod() throws ParseException{
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
		Period p = periodService.getObject("Period.getNextPeriod", null);
		boolean flag = true;
		if(p==null){
			p = periodService.getObject("Period.getFirstPeriod", null);
			flag= false;
		}
		String d = f.format(new Date())+" ";
		f= new SimpleDateFormat("HH-mm-ss");
		d+=f.format(p.getTime());
		f = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		long t = flag?f.parse(d).getTime():f.parse(d).getTime()+24*3600*100;
		flushJson("{time:"+t+",period:'"+p.getTimePeriod()+"'}");
	}
}

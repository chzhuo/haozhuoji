package com.haozhuoji.mall.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Period;
import com.haozhuoji.mall.service.PeriodService;

@Service("periodService")
public class PeriodServiceImpl extends BaseServiceImpl<Period> implements PeriodService{
	
	/**
	 * 得到当天的时段
	 * @return
	 * @throws Exception
	 */
	public List<Period> getTodayPeriod(Date date) throws Exception{
		Period period = new Period();
		period.setDate(date);
		List<Period> periodList = this.getList("Period.getList",period);
		if(periodList.size()==0){
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			period = new Period();
			period.setWeekday(c.get(c.DAY_OF_WEEK)-1);
			periodList = this.getList("Period.getList",period);
		}
		return periodList;
	}
	/**
	 * 得到第二天的时段
	 * @return
	 * @throws Exception
	 */
	public List<Period> getTomPeriod(Date date) throws Exception{
		Period period = new Period();
		date.setTime(date.getTime()+60*60*24*1000);
		period.setDate(date);
		List<Period> periodList = this.getList("Period.getList",period);
		if(periodList.size()==0){
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			period = new Period();
			period.setWeekday(c.get(c.DAY_OF_WEEK)-1);
			periodList = this.getList("Period.getList",period);
		}
		return periodList;
	}
	
	public Period getPeriod(Period period){
		Period p = this.getObject("Period.getList",period);
		if(p==null){
			Calendar c = Calendar.getInstance();
			c.setTime(period.getDate());
			period.setDate(null);
			period.setWeekday(c.get(c.DAY_OF_WEEK)-1);
			period = this.getObject("Period.getList",period);
			return period;
		}else{
			return p;
		}
	}
}

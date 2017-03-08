package com.haozhuoji.mall.service;

import java.util.Date;
import java.util.List;

import com.haozhuoji.mall.domain.Period;

public interface PeriodService extends BaseService<Period>{
	public List<Period> getTodayPeriod(Date date) throws Exception;
	public List<Period> getTomPeriod(Date date) throws Exception;
	public Period getPeriod(Period period);
}

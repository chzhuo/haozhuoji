package com.haozhuoji.mall.domain;

import java.util.Date;

public class Period {
	private Long periodID;
	private Date time;
	private String timePeriod;
	private Integer weekday;
	private Date date;
	private Date printTime;
	private Integer aheadOfDay;
	//
	private Boolean outTime;
	
	public Integer getAheadOfDay() {
		return aheadOfDay;
	}
	public void setAheadOfDay(Integer aheadOfDay) {
		this.aheadOfDay = aheadOfDay;
	}
	public Date getPrintTime() {
		return printTime;
	}
	public void setPrintTime(Date printTime) {
		this.printTime = printTime;
	}
	public Boolean getOutTime() {
		return outTime;
	}
	public void setOutTime(Boolean outTime) {
		this.outTime = outTime;
	}
	public Long getPeriodID() {
		return periodID;
	}
	public void setPeriodID(Long periodID) {
		this.periodID = periodID;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getTimePeriod() {
		return timePeriod;
	}
	public void setTimePeriod(String timePeriod) {
		this.timePeriod = timePeriod;
	}
	public Integer getWeekday() {
		return weekday;
	}
	public void setWeekday(Integer weekday) {
		this.weekday = weekday;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
}

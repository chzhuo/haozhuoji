package com.haozhuoji.mall.util;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	public static String[] weekdays = {"星期日","星期一","星期二","星期三","星期四","星期五","星期六"};
	public static String date_str(Date date){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(date);
	}
	
	public static String getWeek(Date date){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return weekdays[c.get(c.DAY_OF_WEEK)-1];
	}
	
	public static String format_dateTime(Date date){
		if(date==null){
			return "-";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}
	
	public static String format_dateTime(Long timeStamp){
		if(timeStamp==null){
			return "-";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(new Date(timeStamp));
	}
	
	public static String format(Long timeStamp){
		if(timeStamp==null){
			return "-";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(new Date(timeStamp));
	}
	
	public static String format(Date date){
		if(date==null){
			return "-";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}
	public static String formatTime(Date date){
		if(date==null){
			return "-";
		}
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
		return format.format(date);
	}
	public static String formatDate(Date date){
		if(date==null){
			return "-";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(date);
	}
}

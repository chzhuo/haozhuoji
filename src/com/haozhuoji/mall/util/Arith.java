package com.haozhuoji.mall.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class Arith {
	private static final int DEF_DIV_SCALE = 2;
	private Arith(){}
	
	/**
     * 提供精确的加法运算。
     * @param v1 被加数
     * @param v2 加数
     * @return 两个参数的和
     */
    public static double add(double v1,double v2){
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.add(b2).doubleValue();
    }
    public static double sub(double v1,double v2){
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.subtract(b2).doubleValue();
    }

    public static double mul(double v1,double v2){
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2).doubleValue();
    }

    public static double div(double v1,double v2){
        return div(v1,v2,DEF_DIV_SCALE);
    }
    
    /**
     * 格式化后返回字符串
     * @param v1
     * @param v2
     * @return
     */
    public static String addFormat(double v1,double v2){
    	BigDecimal b1 = new BigDecimal(Double.toString(v1));
    	BigDecimal b2 = new BigDecimal(Double.toString(v2));
    	return format(b1.add(b2).doubleValue());
    }
    public static String subFormat(double v1,double v2){
    	BigDecimal b1 = new BigDecimal(Double.toString(v1));
    	BigDecimal b2 = new BigDecimal(Double.toString(v2));
    	return format(b1.subtract(b2).doubleValue());
    }
    
    public static String mulFormat(double v1,double v2){
    	BigDecimal b1 = new BigDecimal(Double.toString(v1));
    	BigDecimal b2 = new BigDecimal(Double.toString(v2));
    	return format(b1.multiply(b2).doubleValue());
    }
    
    public static String divFormat(double v1,double v2){
    	return format(div(v1,v2,DEF_DIV_SCALE));
    }

    /**
     * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指
     * 定精度，以后的数字四舍五入。
     */
    public static double div(double v1,double v2,int scale){
        if(scale<0){
            throw new IllegalArgumentException(
                "The scale must be a positive integer or zero");
        }
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.divide(b2,scale,BigDecimal.ROUND_HALF_UP).doubleValue();
    }
    public static double round(double v,int scale){
        if(scale<0){
            throw new IllegalArgumentException(
                "The scale must be a positive integer or zero");
        }
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal("1");
        return b.divide(one,scale,BigDecimal.ROUND_HALF_UP).doubleValue();
    }
    
    public static String format(Number number){
    	if(number==null){
    		return "";
    	}
    	DecimalFormat format = new DecimalFormat("0.00");
    	return format.format(number);
    }
}

package com.haozhuoji.mall.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class DataUtil {
	public static String md5(String src){
		try {
			MessageDigest md5 = MessageDigest.getInstance("md5");
			char[] chars = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
			byte[] md5b = md5.digest(src.getBytes());
			StringBuffer sb = new StringBuffer();
			for(byte b:md5b){
				sb.append(chars[b>>4 & 0xF]);
				sb.append(chars[b & 0xF]);
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 如果对象是字符串，转换为utf-8返回，如果是bean，则对飞空字符串转换返回
	 * @param object
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public static Object toUTF8(Object object) throws UnsupportedEncodingException, IllegalArgumentException, IllegalAccessException{
		if(object==null){
			return null;
		}
		if(object instanceof String){
			return new String(((String) object).getBytes("iso8859-1"));
		}else{
			for(Field f:object.getClass().getDeclaredFields()){
				f.setAccessible(true);
				Object o = f.get(object);
				if(o!=null&&o instanceof String){
					f.set(object,new String(((String) o).getBytes("iso8859-1")));
				}
			}
			return object;
		}
	}
	
	/**
	 * 对类名进行处理
	 * @param src
	 * @return
	 */
	public static String typeSplit(String src){
		if(src==null){
			return null;
		}else if(src.equals("")){
			return "";
		}
		if(src.replaceAll("-", "").matches("^\\d+$")){
			return src.replaceAll("0-(\\d+)", "$1").replaceAll("-", ">");
		}else{			
			return src.replaceAll("全部类-(\\d+)", "$1").replaceAll("-", ">");
		}
	}
}

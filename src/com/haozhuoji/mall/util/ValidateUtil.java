package com.haozhuoji.mall.util;


public class ValidateUtil {
//	public static boolean 
	public static boolean validateString(String src){
		if(src!=null&&!src.trim().equals("")){
			return true;
		}
		return false;
	}
	public static boolean checkEmail(String email){
		if(!ValidateUtil.validateString(email)){
			return false;
		}
		String regex = "^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$";
		return email.matches(regex);
	}
}

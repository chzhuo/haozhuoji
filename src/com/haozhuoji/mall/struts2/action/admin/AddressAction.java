package com.haozhuoji.mall.struts2.action.admin;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.ValidateUtil;

public class AddressAction extends BaseAction<Address>{
	
//	/**
//	 * 保存收货地址
//	 * @return
//	 */
//	public String saveAddress(){
//		message="false";
//		if(!ValidateUtil.validateString(addre.getName())||!addre.getName().matches("[\\u0391-\\uFFE5]{2,15}")){
//			message="收货人格式出错";
//		}else if(!ValidateUtil.validateString(addre.getAddress())){
//			message="请输入收货地址";
//		}else if(!ValidateUtil.validateString(addre.getCellphone())||!addre.getCellphone().matches("1\\d{10}")){
//			message="手机号码格式出错";
//		}
//
//		if(!message.equals("false")){
//			return "message";
//		}
//		Address a = new Address();
//		BeanUtils.copyProperties(addre,a);
//		User user = (User) ServletActionContext.getRequest().getSession().getAttribute("userBean");
//		if(user==null){
//			return "message";
//		}
//		a.setUser(user);
//		addre = userService.saveAddress(a);
//		message ="true";
//		
//		return "message";
//	}
//	
//	public String deleteAddress(){
//		User user = (User) ServletActionContext.getRequest().getSession().getAttribute("userBean");
//		if(user==null){
//			return "index";
//		}
//		userService.deleteAddressById(addre.getId());
//		return "href";
//	}
}

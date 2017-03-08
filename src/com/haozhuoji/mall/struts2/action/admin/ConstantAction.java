package com.haozhuoji.mall.struts2.action.admin;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain._Constant;
import com.haozhuoji.mall.service.ConstantService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("constantAction")
@Scope("prototype")
public class ConstantAction extends BaseAction<_Constant>{
	@Resource(name="constantService")
	private ConstantService constantService;
	
	public String getSlider(){
		return null;
	}
}

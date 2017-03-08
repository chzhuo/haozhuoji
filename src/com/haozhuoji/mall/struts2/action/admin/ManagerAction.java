package com.haozhuoji.mall.struts2.action.admin;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

@Controller("managerAction")
@Scope("prototype")
public class ManagerAction extends ActionSupport {
	private String pageName;
	
	
	public String getPageName() {
		return pageName;
	}


	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	//转发到管理页面
	public String execute(){
		return "index";
	}
	
	//负责转发页面
	public String forward(){
		return "forward";
	}
}

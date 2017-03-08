package com.haozhuoji.mall.struts2.action.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.haozhuoji.mall.util.ValidateUtil;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AdminLoginInterceptor implements Interceptor{
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		String username = (String) ServletActionContext.getRequest().getSession().getAttribute("AdminUser");
		
		if(ValidateUtil.validateString(username)&&username.equals("admin")){
			return invocation.invoke();
		}else{
			HttpServletRequest re = ServletActionContext.getRequest();
			username = re.getParameter("username");
			String password = re.getParameter("password");
			if(ValidateUtil.validateString(password)&&ValidateUtil.validateString(username)&&username.equals("admin")&&password.equals("@aitoday.cc")){
				ServletActionContext.getRequest().getSession().setAttribute("AdminUser",username);
				return invocation.invoke();
			}
			return "loginPage";
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}

}

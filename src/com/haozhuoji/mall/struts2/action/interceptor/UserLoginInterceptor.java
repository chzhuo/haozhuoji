package com.haozhuoji.mall.struts2.action.interceptor;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.haozhuoji.mall.domain.Cart;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.CartService;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@Component("userLoginInterceptor")
public class UserLoginInterceptor implements Interceptor {
	

	
	@Override
	public void destroy() {
		
	}
	@Override
	public void init() {
		
	}
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		User user = (User) ServletActionContext.getRequest().getSession().getAttribute("userBean");
		String url = ServletActionContext.getRequest().getRequestURL().toString();
		if(user==null){
			if(url.endsWith(".action")){
				ServletActionContext.getResponse().setCharacterEncoding("utf-8");
				ServletActionContext.getResponse().getWriter().write("{'isLogin':'no','message':'您尚未登录，请刷新登录！'}");
				return null;
			}else{				
				return "login";
			}
		}else{
			return invocation.invoke();
		}
	}
}

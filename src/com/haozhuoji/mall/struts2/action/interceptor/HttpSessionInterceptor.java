package com.haozhuoji.mall.struts2.action.interceptor;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * httpsession拦截器
 * @author Chen Zhuo
 *
 */
@Component("httpSessionInterceptor")
public class HttpSessionInterceptor implements Interceptor{

	@Override
	public void destroy() {
	}

	@Override
	public void init() {
	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		if(invocation.getAction() instanceof HttpSessionAware){
			HttpSessionAware hsa = (HttpSessionAware)invocation.getAction();
			hsa.setSession(ServletActionContext.getRequest().getSession());
		}
		return invocation.invoke();
	}

}

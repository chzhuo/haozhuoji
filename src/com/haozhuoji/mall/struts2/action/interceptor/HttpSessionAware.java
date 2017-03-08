package com.haozhuoji.mall.struts2.action.interceptor;

import javax.servlet.http.HttpSession;

public interface HttpSessionAware {
	public void setSession(HttpSession session);
}

package com.haozhuoji.mall.struts2.action;

import java.io.IOException;
import java.lang.reflect.ParameterizedType;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.struts2.action.interceptor.HttpSessionAware;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

public abstract class BaseAction<T> extends ActionSupport implements ModelDriven<T>,Preparable,HttpSessionAware,ServletRequestAware,ServletResponseAware{

	private static final long serialVersionUID = -5294672943824723603L;
	
	public HttpServletRequest request;
    
	public HttpServletResponse response;
	
	public HttpSession session;
	
	public User user;
	
	public T model;
	
	public BaseAction(){
		try {
			ParameterizedType type = (ParameterizedType) this.getClass().getGenericSuperclass();
			Class<T> clazz = (Class<T>) type.getActualTypeArguments()[0];
			model = clazz.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String flushJson(String json){
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public T getModel() {
		return model;
	}
	@Override
	public void prepare() throws Exception {
	}


	@Override
	public void setSession(HttpSession session) {
		user = (User) session.getAttribute("userBean");
		this.session = session;
	}
	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		response = arg0;
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		request = arg0;
	}
}

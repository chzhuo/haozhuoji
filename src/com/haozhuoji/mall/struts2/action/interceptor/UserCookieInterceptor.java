package com.haozhuoji.mall.struts2.action.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DesEncrypt;
import com.haozhuoji.mall.util.ValidateUtil;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@Component("userCookieInterceptor")
public class UserCookieInterceptor implements Interceptor{
	
	@Resource(name="userService")
	private UserService userService;
	
	@Override
	public void destroy() {
	}

	@Override
	public void init() {
	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		HttpServletRequest request =  ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		//判断域名是否正确
		String url = request.getRequestURL().toString();
		if(!url.replaceAll("(.*://)(.+?)(/.*)", "$2").equals(Constant.domain)){
			response.sendRedirect(url.replaceAll("(.*://)(.+?)(/.*)", "$1"+Constant.domain+"$3"));
			return null;
		}
		   
		User user = (User) request.getSession().getAttribute("userBean");
		
		//userBean为空时，查看cookie
		if(user==null){
			Cookie[] cookies = request.getCookies();
			if(cookies!=null){				
				for(Cookie c : cookies){
					if(c.getName().equals("haozhuojiid")&&ValidateUtil.validateString(c.getValue())){
						try {
							DesEncrypt desEncrypt = new DesEncrypt(Constant.userCookieEncryptKey);
							String value = desEncrypt.getDesString(c.getValue());
							String[] values = value.split("_");
							
							//判断时间
							if(Long.parseLong(values[1])<System.currentTimeMillis()){
								removeCookie();
								break;
							}
							
							//判断用户ID
							user = new User();
							user.setUserID(Long.parseLong(values[0]));
							user = userService.getObject("User.getObject",user);
							if(user!=null){
								request.getSession().setAttribute("userBean", user);
							}
						} catch (Exception e) {
							removeCookie();
						}
						break;
					}
				}
			}
		}
		return invocation.invoke();
	}
	
	private void removeCookie(){
		Cookie c = new Cookie("haozhuojiid",null);
		c.setDomain(".haozhuoji.com");
		c.setMaxAge(0);
		c.setPath("/");
		ServletActionContext.getResponse().addCookie(c);
	}
}

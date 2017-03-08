package com.haozhuoji.mall.struts2.action;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.Servlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DataUtil;
import com.haozhuoji.mall.util.DesEncrypt;
import com.haozhuoji.mall.util.ValidateUtil;
import com.haozhuoji.mall.util.Verify;
import com.haozhuoji.mall.util.mail.MailUtil;


@Controller("loginRegisterAction")
@Scope("prototype")
public class LoginRegisterAction extends BaseAction<User>{
	
	@Resource(name="userService")
	private UserService userService;
	
	//验证码
	private String verify;
	
	//返回当前路径
	private String href;
	
	/**
	 * 转到注册页面
	 * @return
	 */
	public String toRegister(){
		return "register";
	}
	
	/**
	 * 转到登陆页面
	 * @return
	 */
	public String toLogin(){
		return "login";
	}
	
	/**
	 * 注册
	 * @return
	 */
	public String register(){
		String json = "{";
		if(!ValidateUtil.checkEmail(model.getEmail())){
			json+="email:'errorMess',";
		}else if(!userService.checkEmailIsUse(model.getEmail())){
			json+="email:'改邮箱已被注册',";
		}
		String verify = (String) session.getAttribute("verify");
		if(!ValidateUtil.validateString(verify)||!ValidateUtil.validateString(this.verify)||!verify.toLowerCase().equals(this.verify.toLowerCase())){
			json+="verify:'errorMess',";
		}
		if(!ValidateUtil.validateString(model.getPassword())||!model.getPassword().matches(".{6,20}")){
			json+="'password:'errorMess',";		
		}
		if(!ValidateUtil.validateString(model.getNickName())||!model.getNickName().matches(".{1,15}")){
			json+="'nickName':'errorMess',";			
		}
		
		json = json.substring(0, json.length()-1);
		if(!json.equals("")){
			json+=",'flag':'false'}";
			return this.flushJson(json);
		}
		
		User u = new User();
		u.setEmail(model.getEmail());
		u.setNickName(model.getNickName());
		u.setPassword(model.getPassword());
		
		try {
			userService.saveUser(u);
		} catch (Exception e) {
			e.printStackTrace();
			json="'error':'服务器忙，请稍后再试'";
			return this.flushJson(json);
		}
		try{
			u = userService.getObject("User.getObject",u);
			ServletActionContext.getRequest().getSession().setAttribute("userBean", u);
		}catch(Exception e){
			e.printStackTrace();
		}
		json="{'flag':'true'}";
		return this.flushJson(json);
	}
	/**
	 * 用户登陆
	 * @return
	 * @throws Exception 
	 */
	public String login() throws Exception{
		String json;
		if(!ValidateUtil.checkEmail(model.getEmail())||!ValidateUtil.validateString(model.getPassword())||!model.getPassword().matches(".{6,20}")){
			json="{'flag':'false'}";
			return this.flushJson(json);
		}else{
			User user = new User();
			user.setEmail(model.getEmail());
			user.setPassword(DataUtil.md5(model.getPassword()));
			
			try {
				user = userService.getObject("User.getObject",user);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				json="{'flag':'false'}";
				return this.flushJson(json);
			}
			
			if(user==null){
				json="{'flag':'false'}";
			}else{
				Cookie c =null;
				if(request.getParameter("autoLogin")!=null&&request.getParameter("autoLogin").equals("true")){
					DesEncrypt de = new DesEncrypt(Constant.userCookieEncryptKey);
					String src = de.getEncString(user.getUserID()+"_"+(System.currentTimeMillis()+180*24*3600*100));
					c = new Cookie("haozhuojiid",src);
					c.setMaxAge(3600*24*180);
				}else{
					c = new Cookie("haozhuojiid",null);
					c.setMaxAge(0);
				}
				c.setPath("/");
				c.setDomain(".haozhuoji.com");
				ServletActionContext.getResponse().addCookie(c);
				
				ServletActionContext.getRequest().getSession().setAttribute("userBean", user);
				json="{'flag':'true'}";
			}
		}
		return this.flushJson(json);
	}
	
	/**
	 * 登录ajax返回
	 * @return
	 */
	public String loginFrame(){
		response.setCharacterEncoding("utf-8");
		return "loginFrame";
	}
	
	/**
	 * 退出登录
	 * @return
	 */
	public String logout(){
		User user = (User) session.getAttribute("userBean");
		if(user!=null){
			ServletActionContext.getRequest().getSession().removeAttribute("userBean");
		}
		
		Cookie c = new Cookie("haozhuojiid",null);
		c.setDomain(".haozhuoji.com");
		c.setMaxAge(0);
		c.setPath("/");
		ServletActionContext.getResponse().addCookie(c);
		return "href";
	}
	
	/**
	 * 检测邮箱是否已经被使用
	 * @return
	 * @throws IOException 
	 */
	public String  checkEmail() throws IOException{
		String json=null;
		if(userService.checkEmailIsUse(model.getEmail())){
			json="{'flag':'true'}";
		}else{
			json="{'flag':'false'}";
		}
		return this.flushJson(json);
	}

	/**
	 * 得到验证码图片，并输出到浏览器
	 */
	public void getVerify(){
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = ServletActionContext.getRequest().getSession();
        response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片
        response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        session.setAttribute("verify",new Verify().getRandcode(response).toLowerCase());	
	}
	/**
	 * 验证 验证码
	 * @return 返回字符串，为false验证失败
	 */
	public String checkVerify(){
		String json="{'flag':'false'}";
		HttpSession session = ServletActionContext.getRequest().getSession();
		String verify = (String) session.getAttribute("verify");
		if(ValidateUtil.validateString(this.verify)&&ValidateUtil.validateString(verify)){			
			if(verify.equals(this.verify.toLowerCase())){
				json="{'flag':'true'}";
			}
		}
		return this.flushJson(json);
	}
	
	/**
	 * 忘记密码
	 * @return
	 */
	public String forgettenPassword(){
		return "forgettenPassword";
	}
	/**
	 * 发送找回密码邮件
	 */
	public void sendEmail(){
		//验证验证码
		HttpSession session = ServletActionContext.getRequest().getSession();
		String verify = (String) session.getAttribute("verify");
		if(!ValidateUtil.validateString(this.verify)||!ValidateUtil.validateString(verify)||!verify.equals(this.verify.toLowerCase())){			
			flushJson("{'status':'验证码错误'}");
			session.removeAttribute("verify");
			return ;
		}
		
		//验证邮箱
		if(userService.checkEmailIsUse(model.getEmail())){
			flushJson("{'status':'不存在该邮箱！'}");
		}else{
			try {
				User user = new User();
				user.setEmail(model.getEmail());
				user = userService.getObject("User.getObject", user);
				String src = user.getEmail()+"spe_spe"+(System.currentTimeMillis()+24*3600*1000);
				DesEncrypt de = new DesEncrypt(Constant.emailEncryptKey);
				src = de.getEncString(src);
				MailUtil.sendGetPasswordMail(model.getEmail(),src, user.getNickName());
			} catch (Exception e) {
				flushJson("{'status':'邮件发送出错，请稍后再试！'}");
			}
			
			flushJson("{'status':'success','email':'mail."+model.getEmail().split("@")[1]+"'}");
		}
	}
	
	/**
	 * 发送邮件成功页面
	 * @return
	 */
	public String sendEmailSuccess(){
		request.setAttribute("email", request.getParameter("email"));
		return "sendEmailSuccess";
	};
	/**
	 * 转到修改密码页面
	 * @return
	 */
	public String getPassword(){
		String source = request.getParameter("source");
		if(!ValidateUtil.validateString(source)){
			request.setAttribute("error", "参数错误");
		}else{			
			try {
				DesEncrypt de = new DesEncrypt(Constant.emailEncryptKey);
				source = de.getDesString(source);
				String[] src = source.split("spe_spe");
				if(Long.parseLong(src[1])<System.currentTimeMillis()){
					request.setAttribute("error", "该链接已经过期！");
				}else{
					User user = new User();
					user.setEmail(src[0]);
					user = userService.getObject("User.getObject", user);
					if(user==null){
						request.setAttribute("error", "参数错误");
					}else{
						request.setAttribute("source", request.getParameter("source"));
					}
				}
			} catch (Exception e) {
				request.setAttribute("error", "参数错误");
			}
		}
		return "getPassword";
	}
	
	/**
	 * 修改密码
	 */
	public void changePassword(){
		String source = request.getParameter("source");
		if(!ValidateUtil.validateString(source)){
			flushJson("{status:'参数错误'}");
		}else if(model.getPassword()==null){
			flushJson("{status:'密码不能为空！'}");			
		}else if(!model.getPassword().matches(".{6,20}")){
			flushJson("{status:'密码格式错误！'}");						
		}else{			
			try {
				DesEncrypt de = new DesEncrypt(Constant.emailEncryptKey);
				source = de.getDesString(source);
				String[] src = source.split("spe_spe");
				if(Long.parseLong(src[1])<System.currentTimeMillis()){
					flushJson("{status:'参数错误'}");
				}else{
					User user = new User();
					user.setEmail(src[0]);
					user = userService.getObject("User.getObject", user);
					if(user==null){
						flushJson("{status:'参数错误'}");
					}else{
						User u = new User();
						u.setUserID(user.getUserID());
						u.setPassword(DataUtil.md5(model.getPassword()));
						userService.update("User.updatePassword", u);
						flushJson("{status:'success'}");
					}
				}
			} catch (Exception e) {
				flushJson("{status:'参数错误'}");
			}
		}
	}
	/**
	 * 转到密码成功页面
	 * @return
	 */
	public String successRePassword(){
		return "successRePassword";
	}
	
	
//	getter and setter
	public void setVerify(String verify) {
		this.verify = verify;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}
}

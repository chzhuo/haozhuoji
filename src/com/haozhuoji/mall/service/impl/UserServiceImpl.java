package com.haozhuoji.mall.service.impl;

import java.util.Date;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.util.DataUtil;

@Service("userService")
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService{
	
	/**
	 * 检测邮箱是否可用
	 * @param email
	 * @return
	 */
	public boolean checkEmailIsUse(String email){
		User u = new User();
		u.setEmail(email);
		try {
			u = this.getObject("User.getObject",u);
			if(u!=null){
				return false;
			}else{
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 增加用户
	 * @param user
	 * @throws Exception 
	 */
	public void saveUser(User user) throws Exception{
		user.setPassword(DataUtil.md5(user.getPassword()));
		user.setPoints(0);
		user.setWallet(0D);
		user.setLevel(0);
		user.setFlag(0L);
		user.setCreateDateTime(new Date());
		this.insert("User.add",user);
	}
	
	@Override
	public void updateUserBean(){
		User user = (User) ServletActionContext.getRequest().getSession().getAttribute("userBean");
		User u = new User();
		u.setUserID(user.getUserID());
		u=this.getObject("User.getObject",u);
		 ServletActionContext.getRequest().getSession().setAttribute("userBean", u);
	}
}

package com.haozhuoji.mall.service;

import java.util.Set;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.User;

public interface UserService extends BaseService<User> {
	public boolean checkEmailIsUse(String email);
	public void saveUser(User user) throws Exception;
	public void updateUserBean();
}

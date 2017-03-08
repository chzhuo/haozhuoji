package com.haozhuoji.mall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.dao.BaseDao;
import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.service.AddressService;

@Service("addressService")
public class AddressServiceImpl extends BaseServiceImpl<Address> implements AddressService{

	public void add(Address t) throws Exception {
		super.insert("Address.add",t);
	}

	public void update(Address t) throws Exception {
		// TODO Auto-generated method stub
		super.update("Address.update",t);
	}

	public void delete(Address t) throws Exception {
		// TODO Auto-generated method stub
		super.delete("Address.delete",t);
	}
	
	public Integer getCount(Address address) throws Exception{
		return super.getInt("Address.getCount",address);
	}
}

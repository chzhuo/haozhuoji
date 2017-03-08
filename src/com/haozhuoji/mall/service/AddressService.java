package com.haozhuoji.mall.service;

import com.haozhuoji.mall.domain.Address;

public interface AddressService extends BaseService<Address> {
	public void add(Address t) throws Exception;

	public void update(Address t) throws Exception;

	public void delete(Address t) throws Exception;
	public Integer getCount(Address t) throws Exception;
}

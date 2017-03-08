package com.haozhuoji.mall.struts2.action.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.service.AddressService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.Constant;

@Controller("addressAction")
@Scope("prototype")
public class AddressAction extends BaseAction<Address> {
	
	@Resource(name="addressService")
	private AddressService addressService;
	
	/**
	 * 增加地址
	 * @throws Exception
	 */
	public void addAjax() throws Exception{
		if(model.getName()!=null&&model.getName().matches("[\u0391-\uFFE5]{2,10}")&&model.getCellphone()!=null&&model.getCellphone().matches("1\\d{10}")&&model.getAddress()!=null&&model.getAddress().matches(".{1,25}")){			
			Address a = new Address();
			a.setUserID(user.getUserID());
			if(this.addressService.getCount(a)>Constant.maxOfAddress){				
				this.flushJson("{'message':'最多只能存储"+Constant.maxOfAddress+"个地址！'}");
				return;
			}
			a.setAddress(model.getAddress());
			a.setCellphone(model.getCellphone());
			a.setFlag(0L);
			a.setName(model.getName());
			this.addressService.add(a);
			this.flushJson("{'addressID':'"+a.getAddressID()+"'}");
		}else{
			this.flushJson("{'message':'参数异常，请刷新后重试！'}");
		}
	}
	
	/**
	 * 更改地址
	 * @throws Exception
	 */
	public void updateAjax() throws Exception{
		if(model.getAddressID()==null){
			this.flushJson("{'message':'参数异常，请刷新后重试！'}");
			return;
		}
		Address a = new Address();
		a.setUserID(user.getUserID());
		a.setAddressID(model.getAddressID());
		a.setAddress(model.getAddress());
		a.setCellphone(model.getCellphone());
		a.setFlag(model.getFlag());
		a.setName(model.getName());
		this.addressService.update(a);
	}
	
	/**
	 * 删除地址
	 * @throws Exception
	 */
	public void deleteAjax() throws Exception{
		if(model.getAddressID()==null){
			this.flushJson("{'message':'参数异常，请刷新后重试！'}");
			return;
		}
		try {
			Address a = new Address();
			a.setAddressID(model.getAddressID());
			a.setUserID(user.getUserID());
			this.addressService.delete(a);
		} catch (Exception e) {
			e.printStackTrace();
			this.flushJson("{'message':'修改失败，请刷新后重试！'}");
			return;
		}
	}
	/**
	 * 修改默认地址
	 * @throws Exception
	 */
	public void setDefaultAjax() throws Exception{
		if(model.getAddressID()==null){
			this.flushJson("{'message':'参数异常，请刷新后重试！'}");
			return;
		}
		Address a = new Address();
		a.setParamFlag(-1L);
		a.setFlag(1L);
		a.setUserID(user.getUserID());
		this.addressService.update(a);
		
		a.setParamFlag(1L);
		a.setFlag(0L);
		a.setAddressID(model.getAddressID());
		this.addressService.update(a);
	}
}

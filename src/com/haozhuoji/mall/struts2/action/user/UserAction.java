package com.haozhuoji.mall.struts2.action.user;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.Coupon;
import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.domain.PointToCoupon;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.AddressService;
import com.haozhuoji.mall.service.CouponService;
import com.haozhuoji.mall.service.OrderService;
import com.haozhuoji.mall.service.PointToCouponService;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.Arith;
import com.haozhuoji.mall.util.DataUtil;


@Controller("userAction")
@Scope("prototype")
public class UserAction extends BaseAction<User>{
	private static final long serialVersionUID = -6154038575970476328L;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="addressService")
	private AddressService addressService;
	
	@Resource(name="pointToCouponService")
	private PointToCouponService pointToCouponService;
	
	@Resource(name="couponService")
	private CouponService couponService;
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	private Page page=new Page();
	public String index(){
		return "index";
	}
	
	public String userInfo(){
		model=userService.getObject("User.getObject", user);
		return "userInfo";
	}
	
	public void updateUser() throws Exception{
		String ret = "success";
		if(model.getNickName()==null){
			ret = "昵称不能为空！";
			flushJson(ret);
			return;
		}else if(!model.getNickName().matches("^(.){1,15}$")){
			ret = "昵称格式错误，可为中英文，长度小于15!";
			flushJson(ret);
			return;
		}
		if(!model.getName().equals("")&&model.getName()!=null&&!model.getName().matches("^([\u0391-\uFFE5]){2,10}$")){
			ret = "姓名格式错误，2-10个汉字！";
			flushJson(ret);
			return;
		}

		if(!model.getStudentID().equals("")&&model.getStudentID()!=null&&!model.getStudentID().matches("^201\\d{9,9}$")){
			ret = "学号格式错误！";
			flushJson(ret);
			return;
		}
		flushJson(ret);
		User user = new User();
		user.setNickName(model.getNickName());
		user.setName(model.getName());
		user.setStudentID(model.getStudentID());
		user.setUserID(((User)session.getAttribute("userBean")).getUserID());
		userService.update("User.update", user);
		userService.updateUserBean();
	}
	
	public String userAddress(){
		Address a = new Address();
		a.setUserID(user.getUserID());
		request.setAttribute("addressList", addressService.getList("Address.getList", a));
		return "userAddress";
	}
	
	/**
	 * 用户积分
	 * @return
	 */
	public String userPoints(){
		List<PointToCoupon> pointToCouponList = pointToCouponService.getList("PointToCoupon.user_getAllPointToCoupon", null);
		request.setAttribute("pointToCouponList", pointToCouponList);
		this.userInfo();
		return "userPoints";
	}
	//兑换积分
	public void exchangePoints(){
		Long pointToCouponID = Long.parseLong(request.getParameter("pointToCouponID"));
		Long updateTimeStamp = Long.parseLong(request.getParameter("updateTimeStamp"));
		if(pointToCouponID==null||updateTimeStamp==null){
			flushJson("参数异常，请刷新后再试！");
		}else{
			PointToCoupon ptc = new PointToCoupon();
			ptc.setPointToCouponID(pointToCouponID);
			ptc.setUpdateTimeStamp(updateTimeStamp);
			String status = pointToCouponService.exchange(ptc,user);
			flushJson(status);
		}
	}
	
	//查看所有积分
	public String coupon(){
		Coupon  c = new Coupon();
		c.setBindUserID(user.getUserID());
		request.setAttribute("couponList", couponService.getList("Coupon.getList", c));
		return "coupon";
	}
	
	//增加优惠券
	public void addCoupon(){
		String t = request.getParameter("couponNumber");
		if(t==null){
			flushJson("{status:'参数错误，请刷新后再试！'}");
		}else{
			Coupon c = couponService.getNewCoupon(t);
			if(c==null){
				flushJson("{status:'该优惠券不存在！'}");
			}else if(c.getBindUserID()!=null&&!c.getBindUserID().equals(user.getUserID())){
				flushJson("{status:'该优惠券已被其它用户绑定！'}");
			}else if(c.getUsed()){
				flushJson("{status:'该优惠券已经被使用！'}");
			}else if(!c.getIssue()){
				flushJson("{status:'该优惠券暂未发行，请联系管理员！'}");				
			}else if(c.getBindUserID()!=null&&c.getBindUserID().equals(user.getUserID())){
				flushJson("{status:'该优惠券您已经绑定！'}");								
			}else{
				c = new Coupon();
				c.setCouponNumber(t);
				c.setBindUserID(user.getUserID());
				couponService.update("Coupon.update", c);
				flushJson("{status:'success'}");
			}
		}
	}
	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
}

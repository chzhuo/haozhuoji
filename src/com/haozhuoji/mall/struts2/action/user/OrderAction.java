package com.haozhuoji.mall.struts2.action.user;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.Comment;
import com.haozhuoji.mall.domain.Coupon;
import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.OrderParams;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.exception.SubmitOrderException;
import com.haozhuoji.mall.service.AddressService;
import com.haozhuoji.mall.service.CartService;
import com.haozhuoji.mall.service.CommentService;
import com.haozhuoji.mall.service.CouponService;
import com.haozhuoji.mall.service.OrderService;
import com.haozhuoji.mall.service.PeriodService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.Arith;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DataUtil;
import com.haozhuoji.mall.util.DateUtil;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("orderAction")
@Scope("prototype")
public class OrderAction extends BaseAction<Order>{
	
	@Resource(name="orderService")	
	private OrderService orderService;
	
	@Resource(name="cartService")
	private CartService cartService;
	
	@Resource(name="addressService")
	private AddressService addressService;
	
	@Resource(name="periodService")
	private PeriodService periodService;
	
	@Resource(name="couponService")
	private CouponService couponService;
	
	@Resource(name="commentService")
	private CommentService commentService;
	
	private Page page = new Page();
	/**
	 * 确认订单
	 * @return
	 * @throws Exception 
	 */
	public String confirmOrder() throws Exception{
		request.setAttribute("orderTimeStamp", System.currentTimeMillis());
		//核对订单
		Order order = this.orderService.confirmOrder(user);
		
		//获得用户地址
		Address address = new Address();
		address.setUserID(user.getUserID());
		List<Address> addressList = addressService.getList("Address.getList",address);
		request.setAttribute("addressList", addressList);
		
		//得到今天的时段
		Date date = new Date();
		request.setAttribute("todayDate", DateUtil.date_str(date));
		request.setAttribute("todayWeek", DateUtil.getWeek(date));
		request.setAttribute("todayPeriod", this.periodService.getTodayPeriod(date));
		
		//得到明天的时段
		date.setTime(date.getTime()+60*60*24*1000);
		request.setAttribute("tomPeriod", this.periodService.getTodayPeriod(date));
		request.setAttribute("tomDate", DateUtil.date_str(date));
		request.setAttribute("tomWeek", DateUtil.getWeek(date));
		
		//判断是否有优惠券
		if(order.getActivityList().size()==0){
			for(Cookie co:request.getCookies()){
				if(co.getName().equals("couponNumber")){
					if(ValidateUtil.validateString(co.getValue())){
						Coupon coupon = new Coupon();
						coupon.setBindUserID(user.getUserID());
						coupon.setCouponNumber(co.getValue());
						Coupon c = couponService.getObject("Coupon.getCookieCoupon", coupon);
						if(c!=null){
							order.setOrder_price(Arith.sub(order.getOrder_price(),c.getSub()));
							order.setCoupon(c);
						}else{
							Cookie cookie = new Cookie("couponNumber",null);
							cookie.setPath("www.haozhuoji.com/user/");
							response.addCookie(cookie);
						}
					}
					break;
				}
			}
		}
		
		//判断邮费
		if(order.getOrder_price()<Constant.rechSendPrice){
			order.setSend_price(1D);
			order.setOrder_price(Arith.add(order.getOrder_price(), Constant.addSendPrice));
		}else{
			order.setSend_price(0D);
		}
		request.setAttribute("order", order);
		return "confirmOrder";
	}
	
	//提交订单
	public void submitOrder(){
		OrderParams op = new OrderParams();
		try {
			String p=request.getParameter("activitySub");
			op.setActivitySub(Double.parseDouble(p));
			p=request.getParameter("sendPrice");
			op.setSendPrice(Double.parseDouble(p));
			p=request.getParameter("totalGoodsPrice");
			op.setTotalGoodsPrice(Double.parseDouble(p));
			p=request.getParameter("totalPrice");
			op.setTotalPrice(Double.parseDouble(p));
			
			p=request.getParameter("addressID");
			op.setAddressID(Long.parseLong(p));
			p=request.getParameter("periodID");
			op.setPeriodID(Long.parseLong(p));
			p=request.getParameter("orderTimeStamp");
			op.setOrderTimeStamp(Long.parseLong(p));
			p=request.getParameter("date");
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			op.setDate(format.parse(p));
			p=request.getParameter("couponNumber");
			op.setCouponNumber(p);
			p=request.getParameter("leaveMess");
			op.setLeaveMess(p);
			p = request.getParameter("timePeriod");
			op.setLeaveMess(request.getParameter("leaveMessage"));
			if(p==null){
				throw new Exception("参数异常");
			}else{
				op.setTimePeriod(p);
			}
		} catch (Exception e) {
			flushJson("{status:'参数错误，请刷新后再试！'}");
			return;
		}
		try {
			Order order = orderService.submitOrder(op,user);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd ");
			flushJson("{status:'success',dateTime:'"+format.format(order.getDistributionTime())+order.getTimePeriod()+"',price:"+order.getOrder_price()+",orderNumber:'"+order.getOrderNumber()+"'}");
		} catch (SubmitOrderException e) {
			flushJson("{status:'"+e.getLocalizedMessage()+"'}");	
		} catch (ParseException e) {
			e.printStackTrace();
			flushJson("{status:'参数异常'}");
		}
		
	}
	
	/**
	 * ajax得到合适的优惠券
	 */
	public void getCoupon(){
		List<Coupon> couponList = couponService.getAbleCoupon(user.getUserID());
		StringBuffer sb = new StringBuffer();
		sb.append("{coupon:[");
		for(Coupon c:couponList){
			sb.append("{couponNumber:'"+c.getCouponNumber()+"',totalPrice:"+c.getTotalPrice()+",startDateTime:"+(c.getBeginDateTime().getTime()>System.currentTimeMillis()?"false":"true")+",");
			sb.append("sub:"+c.getSub()+",rech:"+c.getRech()+",type:'"+DataUtil.typeSplit(c.getFullTypeName())+"'},");
		}
		if(couponList.size()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]}");
		flushJson(sb.toString());
	}
	
	/**
	 * 输入优惠券
	 */
	public void getNewCoupon(){
		if(ValidateUtil.validateString(model.getCoupon().getCouponNumber())){
			Coupon c = couponService.getNewCoupon(model.getCoupon().getCouponNumber().toUpperCase());
			if(c==null){
				flushJson("{status:'该优惠券不存在！'}");
			}else if(c.getBindUserID()!=null&&!c.getBindUserID().equals(user.getUserID())){
				flushJson("{status:'该优惠券已被其它用户绑定！'}");
			}else if(c.getUsed()){
				flushJson("{status:'该优惠券已经被使用！'}");
			}else if(!c.getIssue()){
				flushJson("{status:'该优惠券暂未发行，请联系管理员！'}");				
			}else if(c.getBeginDateTime().getTime()>System.currentTimeMillis()){
				flushJson("{status:'该优惠券暂未到使用日期！'}");								
			}else if(c.getEndDateTime().getTime()<System.currentTimeMillis()){
				flushJson("{status:'该优惠券已经过期！'}");								
			}else{
				if(c.getRech()>c.getTotalPrice()){
					flushJson("{status:'"+DataUtil.typeSplit(c.getFullTypeName())+" 下商品只有"+Arith.format(c.getTotalPrice())+"元，不足"+Arith.format(c.getRech())+"元'}");
				}else{						
					flushJson("{status:'success',sub:"+c.getSub()+",rech:"+c.getRech()+",couponNumber:'"+c.getCouponNumber()+"',type:'"+DataUtil.typeSplit(c.getFullTypeName())+"'}");
				}
			}
		}
	}
	//成功提交订单
	public String successOrder(){
		request.setAttribute("price", request.getParameter("price"));
		request.setAttribute("dateTime", request.getParameter("dateTime"));
		request.setAttribute("orderNumber", request.getParameter("orderNumber"));
		return "successOrder";
	}
	
	//我的订单
	public String orderPage(){
		Order o = new Order();
		o.setUserID(user.getUserID());
		page.setOptionOfPage(30);
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Order", o);
		hashMap.put("Page", page);
		page.setTotalOption(orderService.getInt("Order.getOrderCount", o));
		List<Order> orderList = orderService.getListHashMap("Order.user_getOrder", hashMap);
		request.setAttribute("orderList", orderList);
		return "orderPage";
	}
	
	//订单详情
	public String orderDetail(){
		if(model.getOrderID()==null){
			return "paramError";
		}else{
			Order order = new Order();
			order.setOrderID(model.getOrderID());
			order.setUserID(user.getUserID());
			order = orderService.getObject("Order.getsingleOrder", order);
			if(order==null){
				return "paramError";
			}
			request.setAttribute("order", order);
		}
		return "orderDetail";
	}
	
	//评论
	public String toComment(){
		if(model.getOrderID()==null){
			return "paramError";
		}else{
			Order order = new Order();
			order.setOrderID(model.getOrderID());
			order.setUserID(user.getUserID());
			order = orderService.getObject("Order.getsingleOrder", order);
			if(order==null){
				return "paramError";
			}
			request.setAttribute("order", order);
		}
		return "comment";
	}
	
	//评论
	public void comment(){
		String oi = request.getParameter("orderGoodsID");
		String gi = request.getParameter("goodsID");
		String p = request.getParameter("point");
		String c = request.getParameter("comment");
		if(oi==null||!oi.matches("\\d+")||gi==null||!gi.matches("\\d+")||c==null||!c.matches(".{10,100}")||p==null||!p.matches("\\d+")){
			flushJson("{status:'参数错误'}");
			return;
		}
		Comment comment = new Comment();
		comment.setContent(c);
		comment.setUserID(user.getUserID());
		comment.setGoodsID(Long.parseLong(gi));
		comment.setOrderGoodsID(Long.parseLong(oi));
		comment.setPoint(Integer.parseInt(p));
		String r = commentService.comment(comment);
		if(r==null){
			flushJson("{status:'success'}");
		}else{
			flushJson("{status:'"+r+"'}");			
		}
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	
}

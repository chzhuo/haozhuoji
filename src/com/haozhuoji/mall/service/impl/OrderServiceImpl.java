package com.haozhuoji.mall.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Activity;
import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.Bundling;
import com.haozhuoji.mall.domain.Cart;
import com.haozhuoji.mall.domain.Coupon;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.OrderGoods;
import com.haozhuoji.mall.domain.OrderParams;
import com.haozhuoji.mall.domain.Period;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.exception.SubmitOrderException;
import com.haozhuoji.mall.service.ActivityService;
import com.haozhuoji.mall.service.AddressService;
import com.haozhuoji.mall.service.BundlingService;
import com.haozhuoji.mall.service.CartService;
import com.haozhuoji.mall.service.CouponService;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.OrderGoodsService;
import com.haozhuoji.mall.service.OrderService;
import com.haozhuoji.mall.service.PeriodService;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.util.Arith;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DataUtil;
import com.haozhuoji.mall.util.ValidateUtil;

@Service("orderService")
public class OrderServiceImpl extends BaseServiceImpl<Order> implements OrderService{
	
	@Resource(name="cartService")
	private CartService cartService;
	
	@Resource(name="activityService")
	private ActivityService activityService;
	
	@Resource(name="couponService")
	private CouponService couponService;
	
	@Resource(name="periodService")
	private PeriodService periodService;
	
	@Resource(name="addressService")
	private AddressService addressService;
	
	@Resource(name="orderGoodsService")
	private OrderGoodsService orderGoodsService;
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="bundlingService")
	private BundlingService bundlingService;
	public Order confirmOrder(User user) throws SubmitOrderException{
		Order order = new Order();
		order.setUserID(user.getUserID());
		//获取商品
		order = cartService.checkCart(order);
		//优惠
		StringBuffer conpouBuffer = new StringBuffer();
		
		
		//查找合适的活动
		double ad = 0D;
		Activity activity = new Activity();
		activity.setUserID(user.getUserID());
		List<Activity> activityList = this.activityService.getList("Activity.getActivityAble",activity);
		order.setActivityList(activityList);
		for(Activity a:activityList){
			ad = Arith.add(ad, a.getSub());
		}
		
		order.setOrder_price(Arith.sub(order.getOrder_price(), ad));
		order.setActivitySub(ad);
		//查找是否挂载优惠券
		order.setOrderCouponInfo(conpouBuffer.toString());
		return order;
	}

	@Override
	public Order submitOrder(OrderParams op,User user) throws SubmitOrderException, ParseException {
		Order order = new Order();
		order.setLeaveMessage(op.getLeaveMess());
		//检查配送时间
		Period period = new Period();
		period.setPeriodID(op.getPeriodID());
		period.setDate(op.getDate());
		period = periodService.getPeriod(period);
		Calendar c1 = null;
		if(period==null||!period.getTimePeriod().equals(op.getTimePeriod())){
			throw new SubmitOrderException("时段已经被更改，请重新确认订单！");
		}else{
			c1 = Calendar.getInstance();
			c1.setTime(op.getDate());
			Calendar c2 = Calendar.getInstance();
			c2.setTime(period.getTime());
			c1.set(c1.HOUR_OF_DAY, c2.get(c2.HOUR_OF_DAY));
			c1.set(c1.MINUTE, c2.get(c2.MINUTE));
			c1.set(c1.SECOND, c2.get(c2.SECOND));
			if(c1.getTime().before(new Date())){
				throw new SubmitOrderException("您选择的时段已经送出，请重新确认订单！");
			}else{
				//配送时间
				order.setTimePeriod(period.getTimePeriod());
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date sendDate = format1.parse(format.format(op.getDate())+" "+period.getTimePeriod().split("-")[1]+":00");
				order.setDistributionTime(sendDate);
				
				//打印时间
				Calendar c = Calendar.getInstance();
				c2.setTime(period.getPrintTime());
				c.set(c.HOUR_OF_DAY, c2.get(c2.HOUR_OF_DAY));
				c.set(c.MINUTE, c2.get(c2.MINUTE));
				c.set(c.SECOND, c2.get(c2.SECOND));
				order.setPrintDateTime(new Date((c.getTime().getTime()-period.getAheadOfDay()*24*60*60*1000)));
			}
		}
		//检查收货地址
		Address address = new Address();
		address.setAddressID(op.getAddressID());
		address=addressService.getObject("Address.getObject", address);
		if(address==null){
			throw new SubmitOrderException("收货地址不存在，请重新确认");
		}else{
			order.setAddress(address.getName()+"spe_spe"+address.getCellphone()+"spe_spe"+address.getAddress());
		}
		
		//检查购物车
		Cart cart = new Cart();
		cart.setUserID(user.getUserID());
		double cartPrice=0;
		int points= 0;
		List<Cart> cartList = cartService.getCart(cart);
		for(Cart c:cartList){
			//判断商品是否下架
			for(Goods g1 :c.getGoodsList()){
				if(!g1.getSell()){
					c.setSell(false);
					break;
				}
			}
			if(!c.getSell()){
				throw new SubmitOrderException("部分商品已下架，请刷新后再试！");
			}
			if(c.getCount()>c.getAmount()){
				throw new SubmitOrderException("对不起，部分商品库存不足，请重新确认订单！");
			}
			points = points + c.getPoints();
			cartPrice=Arith.add(cartPrice,Arith.mul(c.getPrice(),c.getCount()));
		}
		if(!op.getTotalGoodsPrice().equals(cartPrice)){
			throw new SubmitOrderException("对不起，购物车商品被更改，请重新确认订单！");
		}
		if(cartPrice==0){
			throw new SubmitOrderException("购物车没有任何商品，请重新确认订单！");			
		}
		order.setGoods_price(cartPrice);
		order.setOrder_price(cartPrice);
		order.setPoints(points);
		order.setCartList(cartList);
		
		//活动
		double ad = 0D;
		Activity activity = new Activity();
		activity.setUserID(user.getUserID());
		List<Activity> activityList = this.activityService.getList("Activity.getActivityAble",activity);
		order.setActivityList(activityList);
		StringBuffer sb = new StringBuffer();
		for(Activity a:activityList){
			ad = Arith.add(ad, a.getSub());
			sb.append("活动（"+DataUtil.typeSplit(a.getFullTypeName())+"）满"+Arith.format(a.getRech())+"元减"+Arith.format(a.getSub())+"元-"+Arith.format(a.getSub())+"spe_spe");
		}
		if(activityList.size()>0){
			sb.deleteCharAt(sb.length()-7);
		}
		if(!op.getActivitySub().equals(ad)){
			throw new SubmitOrderException("对不起，活动优惠已经被更改，请重新确认订单！");
		}
		order.setActivity_price(ad);
		order.setOrder_price(Arith.sub(order.getOrder_price(), ad));
		
		//优惠券
		if(sb.length()==0&&ValidateUtil.validateString(op.getCouponNumber())){			
			Coupon c= new Coupon();
			c.setCouponNumber(op.getCouponNumber());
			c.setBindUserID(user.getUserID());
			c = couponService.getObject("Coupon.getOrderCoupon", c);
			if(c==null){
				throw new SubmitOrderException("代金券/优惠券"+op.getCouponNumber()+" 不可用，请重新确认！");
			}else{
				if(c.getRech().equals(c.getSub())){					
					sb.append("优惠券（"+c.getCouponNumber()+"）（"+DataUtil.typeSplit(c.getFullTypeName())+"）满"+Arith.format(c.getRech())+"元减"+Arith.format(c.getSub())+"元-"+Arith.format(c.getSub()));
				}else{
					sb.append("代金券（"+c.getCouponNumber()+"）（"+DataUtil.typeSplit(c.getFullTypeName())+"）"+Arith.format(c.getSub())+"元代金券-"+Arith.format(c.getSub()));					
				}
				//更改优惠券已被使用
				Coupon coupon= new Coupon();
				coupon.setCouponID(c.getCouponID());
				coupon.setUsed(true);
				couponService.update("Coupon.update", coupon);
			}
			order.setCoupon_price(c.getSub());
			order.setOrder_price(Arith.sub(order.getOrder_price(), c.getSub()));
		}else{
			order.setCoupon_price(0D);
		}
		order.setOrderCouponInfo(sb.toString());
		
		//配送费
		if(order.getOrder_price()<Constant.rechSendPrice){
			order.setSend_price(Constant.addSendPrice);
			order.setOrder_price(Arith.add(order.getOrder_price(), Constant.addSendPrice));
		}else{
			order.setSend_price(0D);
		}
		if(!order.getSend_price().equals(op.getSendPrice())){
			throw new SubmitOrderException("邮费已经更改，请重新确认！");
		}
		
		//总价格判断
		if(!order.getOrder_price().equals(op.getTotalPrice())){
			throw new SubmitOrderException("订单提交错误，请刷新后再试！");
		}
		
		//订单编号
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Order o = new Order();
		o.setOrderNumber(format.format(op.getDate()));
		o=this.getObject("Order.checkOrderNumber", o);
		if(o==null){
			order.setOrderNumber(format.format(op.getDate())+"0001");
		}else{
			order.setOrderNumber((Long.parseLong(o.getOrderNumber())+1+""));
		}
		
		//初始化订单
		order.setUserID(user.getUserID());
		order.setUserID(user.getUserID());
		order.setLeaveMessage(op.getLeaveMess());
		order.setPrint(false);
		order.setDel(false);
		order.setCancel(false);
		order.setComment(false);
		order.setAddPoint(false);
		//持久化订单
		this.insert("Order.add", order);
		for(Cart c:order.getCartList()){
			OrderGoods og = new OrderGoods();
			og.setOrderID(order.getOrderID());
			og.setGoodsIDs("");
			og.setGoodsName("");
			for(Goods g:c.getGoodsList()){

				og.setGoodsIDs(og.getGoodsIDs()+g.getGoodsID()+"-");
				og.setGoodsName(og.getGoodsName()+g.getBrand()+" "+g.getGoodsName()+g.getSpecification()+" "+"spe_spe");
				
				//更改商品销量和库存
				Goods goods = new Goods();
				goods.setGoodsID(g.getGoodsID());
				if(c.getBundlingID()==null){					
					goods.setAmount(-c.getCount());
				}else{
					Bundling b = new Bundling();
					b.setBundlingID(c.getBundlingID());
					b.setAmount(-c.getCount());
					bundlingService.update("Bundling.update", b);
				}
				goods.setPurchase_count(c.getCount());
				
				goodsService.update("Goods.update", goods);
			}
			og.setGoodsIDs(og.getGoodsIDs().substring(0,og.getGoodsIDs().length()-1));
			og.setGoodsName(og.getGoodsName().substring(0,og.getGoodsName().length()-7));
			og.setUserID(user.getUserID());
			og.setAmount(c.getCount());
			og.setProduct_price(c.getPrice());
			og.setComment("");
			orderGoodsService.insert("OrderGoods.add", og);
		}
		
		//清楚购物车
		cartService.clearCart(user.getUserID());
		
		//再次检测订单是否已经送出
		if(c1.getTime().before(new Date())){
			throw new SubmitOrderException("您选择的时段已经送出，请重新确认订单！");
		}
		return order;
	}

	@Override
	public void checkComment(Long orderID) {
		Order o = new Order();
		o.setOrderID(orderID);
		o = this.getObject("Order.getsingleOrder", o);
		for(OrderGoods og :o.getOrderGoodsList()){
			for(String s:og.getGoodsIDs().split("-")){
				if(!og.getComment().contains(s)){
					return;
				}
			}
		}
		Order order = new Order();
		order.setOrderID(o.getOrderID());
		order.setComment(true);
		this.update("Order.update", order);
	}
}

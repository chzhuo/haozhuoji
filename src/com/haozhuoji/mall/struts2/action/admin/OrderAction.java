package com.haozhuoji.mall.struts2.action.admin;

import java.util.Date;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.service.OrderService;
import com.haozhuoji.mall.service.PeriodService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("adminOrderAction")
@Scope("prototype")
public class OrderAction extends BaseAction<Order>{
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="periodService")
	private PeriodService periodService;
	
	private Page page = new Page();
	public String orderList(){
		page.setOptionOfPage(40);
		Order o = new Order();
		BeanUtils.copyProperties(model, o);
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Page", page);
		hashMap.put("Order", model);
		page.setTotalOption(orderService.getIntHashMap("Order.getAdminCount", hashMap));
		request.setAttribute("orderList", orderService.getListHashMap("Order.getAdminList", hashMap));
		return "orderList";
	}
	
	public String orderMonitor() throws Exception{
		request.setAttribute("periodList", this.periodService.getTodayPeriod(new Date()));
		return "orderMonitor";
	}
	
	//得到为打印订单，可按打印时间和未打印来
	public void getOrder(){
		Order o = new Order();
		//是否按打印时间打印
		if(request.getParameter("byPrintDateTime")==null){
			o.setPrintDateTime(new Date());
		}
		int c = orderService.getInt("Order.orderMonitor", o);
		if(c>0){
			flushJson("{print:'true'}");
		}else{
			flushJson("{print:'false'}");			
		}
	}
	
	//取消订单
	public void cancelOrder(){
		if(model.getOrderID()==null){
			flushJson("{status:'参数错误'}");
		}else{
			Order o = new Order();
			o.setOrderID(model.getOrderID());
			o.setCancel(true);
			orderService.update("Order.update", o);
			flushJson("{status:'success'}");			
		}
	}
	//答应订单
	public String printOrder(){
		Order o = new Order();
		BeanUtils.copyProperties(model, o);
		request.setAttribute("orderList", orderService.getList("Order.printOrder", o));
		return "printOrder";
	}
	
	//改变打印
	public void changePrint(){
		if(model.getOrderIDs()==null){
			flushJson("{status:'参数错误'}");
		}else{
			Order o = new Order();
			BeanUtils.copyProperties(model, o);
			orderService.update("Order.changePrint", o);
			flushJson("{status:'success'}");
		}
	}
	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
}

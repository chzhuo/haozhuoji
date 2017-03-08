package com.haozhuoji.mall.struts2.action.interceptor;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.haozhuoji.mall.domain.Cart;
import com.haozhuoji.mall.domain.KeyWord;
import com.haozhuoji.mall.domain.Promotion;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.CartService;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.service.KeyWordService;
import com.haozhuoji.mall.service.PromotionService;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@Component("cartInterceptor")
public class CartInterceptor implements Interceptor {
	@Resource(name="cartService")
	private CartService cartService;
	
	@Resource(name="keyWordService")
	private KeyWordService keyWordService;
	
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	@Resource(name="promotionService")
	private PromotionService promotionService;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		User user = (User) ServletActionContext.getRequest().getSession().getAttribute("userBean");
		
		//加载购物车
		if(user!=null){			
			//加载购物车到request对象
			Cart cart = new Cart();
			cart.setUserID(user.getUserID());
			ServletActionContext.getRequest().setAttribute("cartList", cartService.getCart(cart));
		}
		
		//加载热词
		KeyWord k = keyWordService.getObject("KeyWord.getHotKeyWords", null);
		ServletActionContext.getRequest().setAttribute("hotKeyWords", k.getWord());
		
		//得到所有类型
		ServletActionContext.getRequest().setAttribute("allGoodsTypeList", goodsTypeService.getList("GoodsType.getAllTypeBySub", null));
		
		//
		Promotion p = new Promotion();
		p.setUpHeader(true);
		ServletActionContext.getRequest().setAttribute("headerPromotionList", promotionService.getList("Promotion.getList", p));
		
		return invocation.invoke();
	}

}

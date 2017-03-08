package com.haozhuoji.mall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Cart;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.CartService;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.util.Arith;


@Service("cartService")
public class CartServiceImpl extends BaseServiceImpl<Cart> implements CartService{
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	//得到购物车适合的单个商品
	@Override
	public Goods getGoodsByGoodID(Long goodsID){
		Goods g = new Goods();
		g.setGoodsID(goodsID);
		return goodsService.getObject("Goods.getCartGoods",g);
	}
	
	/**
	 * 
	 * @param cart
	 * @param putRequest 是否放入request中
	 * @return
	 * @throws Exception
	 */
	public List<Cart> getCart(Cart cart){
		List<Cart> cartList = this.getList("Cart.getCart",cart);
		return cartList;
	}
	
	/**
	 * 检测购物车库存并计算购物车总数和价格，不计算运费和优惠
	 * @throws Exception 
	 */
	@Override
	public Order checkCart(Order order){
		Cart cart = new Cart();
		cart.setUserID(order.getUserID());
		double cartPrice=0;
		int cartCount=0;
		List<Cart> cartList = this.getCart(cart);
		for(Cart c:cartList){
			
			//判断商品是否下架
			for(Goods g :c.getGoodsList()){
				if(!g.getSell()){
					c.setSell(false);
					break;
				}
			}
			
			//如果没有下架
			if(c.getSell()){				
				if(c.getCount()>c.getAmount()){
					//库存不足
					c.setStock(false);
					Cart cp = new Cart();
					cp.setCartID(c.getCartID());
					cp.setCount(c.getAmount()-c.getCount());
					c.setCount(c.getAmount());
					if(c.getCount()<1){
						this.delete("Cart.delete",cp);
					}else{					
						this.update("Cart.update",cp);
					}
				}
			}else{
				c.setCount(0);
				//如果下架，就删除
				Cart cp = new Cart();
				cp.setCartID(c.getCartID());
				this.delete("Cart.delete",cp);
			}
			cartPrice=Arith.add(cartPrice,Arith.mul(c.getPrice(),c.getCount()));
			cartCount+=c.getCount();
		}
		order.setCartList(cartList);
		order.setOrder_price(cartPrice);
		order.setGoods_price(cartPrice);
		return order;
	}
	
	@Override
	public int getSumGoods(){
		Cart cart = new Cart();
		User user = (User) ServletActionContext.getRequest().getSession().getAttribute("userBean");
		cart.setUserID(user.getUserID());
		return this.getInt("Cart.getSumGoods",cart);
	}

	@Override
	public void clearCart(Long userID) {
		Cart cart = new Cart();
		cart.setUserID(userID);
		this.delete("Cart.delete", cart);
	}
}
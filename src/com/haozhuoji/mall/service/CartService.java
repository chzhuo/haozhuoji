package com.haozhuoji.mall.service;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import com.haozhuoji.mall.domain.Cart;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.User;

public interface CartService extends BaseService<Cart> {

	public Goods getGoodsByGoodID(Long goodsID);
	public List<Cart> getCart(Cart cart);
	public Order checkCart(Order order);
	int getSumGoods();
	public void clearCart(Long userID);
}

package com.haozhuoji.mall.service;

import java.text.ParseException;

import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.OrderParams;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.exception.SubmitOrderException;

public interface OrderService extends BaseService<Order> {
	public Order confirmOrder(User user) throws Exception;

	public Order submitOrder(OrderParams op,User user) throws SubmitOrderException, ParseException;

	public void checkComment(Long orderID);
}

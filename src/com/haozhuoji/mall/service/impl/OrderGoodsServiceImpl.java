package com.haozhuoji.mall.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Address;
import com.haozhuoji.mall.domain.Order;
import com.haozhuoji.mall.domain.OrderGoods;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.CartService;
import com.haozhuoji.mall.service.OrderGoodsService;
import com.haozhuoji.mall.util.DateUtil;

@Service("orderGoodsService")
public class OrderGoodsServiceImpl extends BaseServiceImpl<OrderGoods>  implements OrderGoodsService {
}


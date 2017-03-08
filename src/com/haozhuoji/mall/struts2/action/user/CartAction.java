package com.haozhuoji.mall.struts2.action.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Bundling;
import com.haozhuoji.mall.domain.Cart;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.User;
import com.haozhuoji.mall.service.BundlingService;
import com.haozhuoji.mall.service.CartService;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("cartAction")
@Scope("prototype")
public class CartAction extends BaseAction<Cart> {
	
	@Resource(name="cartService")
	private CartService cartService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	@Resource(name="bundlingService")
	private BundlingService bundlingService;
	/**
	 * 根据字符串修改返回前台需要修改的商品   8-2_6-3
	 * @throws Exception
	 * 
	 */
	public void checkCart() throws Exception{
		String checkCartIDs = request.getParameter("checkCartIDs");
		Cart cart = new Cart();
		cart.setUserID(user.getUserID());
		List<Cart> cartList = cartService.getList("Cart.getCart",cart);
		
		//数据库购物车商品时没有
		if(cartList.size()<1){
			//数据库没有，前台有
			if(ValidateUtil.validateString(checkCartIDs)){
				String[] strs = checkCartIDs.split("_");
				String ret = "{'flag':'true','del':[";
				for(String s:strs){
					String cartID = s.split("-")[0];
					ret+="{'cartID':'"+cartID+"'},";
				}
				ret = ret.substring(0, ret.length()-1)+"]}";
				this.flushJson(ret);
				return;
			//数据库前台都没有
			}else{
				this.flushJson("{'flag':'false'}");
				return;
			}
			
		//数据库有商品时
		}else{
			//数据库有，但前台没有
			if(!ValidateUtil.validateString(checkCartIDs)){
				StringBuffer sb = new StringBuffer("{'flag':'true','add':[");
				for(Cart c:cartList){
					sb.append(this.addGoodsJson(c));
					sb.append(",");
				}
				sb.deleteCharAt(sb.length()-1);
				sb.append("]}");
				this.flushJson(sb.toString());
				return;
			//数据库和前台都有商品时
			}else{
				List<Cart> add = new ArrayList<Cart>();
				List<Cart> update = new ArrayList<Cart>();
				List<Long> delete = new ArrayList<Long>();
				
				
				String[] strs = checkCartIDs.split("_");
				for(String s:strs){
					delete.add(Long.parseLong(s.split("-")[0]));
				}
				for(Cart c:cartList){
					boolean flag = true;
					for(int i=0;i<strs.length;i++){
						String[] ss = strs[i].split("-");
						if(c.getCartID()==Long.parseLong(ss[0])){
							flag = false;
							delete.remove(c.getCartID());
							if(c.getCount()!=Integer.parseInt(ss[1])){
								update.add(c);
							}
						}
					}
					if(flag){
						add.add(c);
					}
				}
				
				if(add.size()==0&&update.size()==0&&delete.size()==0){
					this.flushJson("{'flag':'false'}");
					return;
				}
				
				StringBuffer sb = new StringBuffer();
				sb.append("{'flag':'true',");
				if(add.size()>0){					
					sb.append("'add':[");
					for(Cart c:add){
						sb.append(this.addGoodsJson(c));
						sb.append(",");
					}
					sb.deleteCharAt(sb.length()-1);
					sb.append("],");
				}
				if(update.size()>0){					
					sb.append("'update':[");
					for(Cart c:update){
						sb.append("{");
						sb.append("'cartID':'"+c.getCartID()+"',");
						sb.append("'count':'"+c.getCount()+"'},");
					}
					sb.deleteCharAt(sb.length()-1);
					sb.append("],");
				}
				if(delete.size()>0){
					sb.append("'del':[");
					for(Long cartID:delete){
						sb.append("{");
						sb.append("'cartID':'"+cartID+"'},");
					}
					sb.deleteCharAt(sb.length()-1);
					sb.append("],");
				}
				sb.deleteCharAt(sb.length()-1);
				sb.append("}");
				flushJson(sb.toString());
			}
		}
	}
	
	/**
	 * 向购物车增加商品，并返回
	 * @throws Exception
	 */
	public void add() throws Exception{
		if(model.getCount()!=null&&(model.getGoodsID()!=null||model.getBundlingID()!=null)){
			Cart c = new Cart();
			User u = (User) session.getAttribute("userBean");
			c.setGoodsID(model.getGoodsID());
			c.setBundlingID(model.getBundlingID());
			c.setCount(model.getCount());
			c.setCreateDateTime(new Date());
			c.setLastModify(new Date());
			c.setUserID(u.getUserID());
			//验证是否存在该商品
			if(model.getGoodsID()!=null){				
				Goods g = new Goods();
				g.setGoodsID(model.getGoodsID());
				g = goodsService.getObject("Goods.getObject", g);
				if(g==null){
					throw new Exception("参数异常");
				}
			}else{
				Bundling b = new Bundling();
				b.setBundlingID(model.getBundlingID());
				b = bundlingService.getObject("Bundling.getObject", b);
				if(b==null){
					throw new Exception("参数异常");
				}
			}
			//加入购物车
			Cart cart = cartService.getObject("Cart.getObject",c);
			if(cart==null){				
				cartService.insert("Cart.add",c);
				cart = cartService.getObject("Cart.getCart",c);
				String json = "{'flag':'true',add:["+this.addGoodsJson(cart)+"]}";
				this.flushJson(json);
				this.saveLastUpdate();
			}
		}else {
			throw new Exception("参数异常");
		}
	}
	
	/**
	 * 增加购物车json返回
	 * @param cart
	 * @return
	 */
	private String addGoodsJson(Cart cart){
		if(cart==null||cart.getGoodsList().size()==0) return "";
		String re = "{'cartID':'"+cart.getCartID()+"','price':'"+cart.getPrice()+"','amount':'"+cart.getAmount()+"',bundlingID:"+cart.getBundlingID()+",'count':'"+cart.getCount()+"',goods:[";
		for(Goods g:cart.getGoodsList()){
			re+="{'goodsID':'"+g.getGoodsID()+"','goodsName':'"+g.getBrand()+" "+g.getGoodsName()+" "+g.getSpecification()+"','promotion_sentence':'"+g.getPromotion_sentence()+"'},";
		}
		re = re.substring(0,re.length()-1);
		re+="],";
		if(cart.getGoodsList().size()==1){
			re+="goodsID:"+cart.getGoodsList().get(0).getGoodsID()+",";
		}
		re = re.substring(0,re.length()-1);
		re+="}";
		return re;
	}
	
	/**
	 * 更新
	 * @throws Exception
	 */
	public void update() throws Exception{
		if(model.getCartID()!=null&&model.getCount()!=null){
			Cart cart = new Cart();
			User user = (User) session.getAttribute("userBean");
			cart.setUserID(user.getUserID());
			cart.setCartID(model.getCartID());
			cart.setCount(model.getCount());
			cart.setLastModify(new Date());
			cartService.update("Cart.update",cart);
			this.saveLastUpdate();
		}
	}
	/**
	 * 从购物车删除
	 * @throws Exception 
	 */
	public void delete() throws Exception{
		if(model.getCartID()!=null){
			Cart c = new Cart();
			User user = (User) session.getAttribute("userBean");
			c.setUserID(user.getUserID());
			c.setCartID(model.getCartID());
			cartService.delete("Cart.delete",c);
			
			Cart c1 = new Cart();
			c.setUserID(user.getUserID());
			this.saveLastUpdate();
		}
	}
	
	private void saveLastUpdate() throws Exception{
		User user = (User) session.getAttribute("userBean");
		User u = new User();
		u.setUserID(user.getUserID());
		u.setCartTime(new Date());
		this.userService.update("User.update",u);
		this.userService.updateUserBean();
	}
}

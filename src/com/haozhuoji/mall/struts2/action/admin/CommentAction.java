package com.haozhuoji.mall.struts2.action.admin;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Comment;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.service.CommentService;
import com.haozhuoji.mall.struts2.action.BaseAction;

@Controller("commentAction")
@Scope("prototype")
public class CommentAction extends BaseAction<Comment>{
	
	@Resource(name="commentService")
	private CommentService commentService;
	
	private Page page=new Page();
	
	public String commentList(){
		page.setOptionOfPage(40);
		Comment c = new Comment();
		BeanUtils.copyProperties(model, c);
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("Page", page);
		hashMap.put("Comment", model);
		page.setTotalOption(commentService.getIntHashMap("Comment.getCount", hashMap));
		request.setAttribute("commentList", commentService.getListHashMap("Comment.getList", hashMap));
		return "commentList";
	}
	
	public void update(){
		if(model.getCommentID()==null){
			flushJson("{status:'参数错误'}");
		}else {
			Comment c = new Comment();
			BeanUtils.copyProperties(model, c);
			commentService.update("Comment.update", c);
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

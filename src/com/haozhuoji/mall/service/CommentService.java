package com.haozhuoji.mall.service;

import com.haozhuoji.mall.domain.Comment;

public interface CommentService extends BaseService<Comment> {

	public String comment(Comment comment);

}

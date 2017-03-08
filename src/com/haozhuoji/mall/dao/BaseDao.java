package com.haozhuoji.mall.dao;

import java.util.HashMap;
import java.util.List;
/**
 * dao 接口
 * @author UU
 *
 * @param <T>
 */
public interface BaseDao<T> {

	public void insert(String sqlMapId, T t);

	public void update(String sqlMapId, T t);

	public void delete(String sqlMapId, T t);

	public T getObject(String sqlMapId, T t);

	public List<T> getListHashMap(String sqlMapID, HashMap<String, Object> hashMap);
	public List<T> getList(String sqlMapID, T t);

	public Integer getInt(String sqlMapId, T t);
	public Integer getIntHashMap(String sqlMapId, HashMap<String, Object> hashMap);
}

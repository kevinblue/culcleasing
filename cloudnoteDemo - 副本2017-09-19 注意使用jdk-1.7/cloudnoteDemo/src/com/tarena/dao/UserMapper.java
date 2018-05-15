package com.tarena.dao;

import com.tarena.entity.User;

public interface UserMapper {

	User findByName(String userName);
	
	void save(User user);
	
	void update(User user);
	
}

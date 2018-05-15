package com.tarena.dao;

import java.util.List;

import com.tarena.entity.NoteBookType;

public interface NoteBookTypeMapper {

	List<NoteBookType> findSpecialType();
	
	List<NoteBookType> findAllType();
	
}

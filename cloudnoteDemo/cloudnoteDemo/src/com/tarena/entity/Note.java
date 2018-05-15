package com.tarena.entity;

public class Note extends Entity {

	private static final long serialVersionUID = 416147326569677331L;

	private String cn_note_id;//笔记id
	private String cn_notebook_id;//笔记本id
	private String cn_user_id;//用户id
	private String cn_note_status_id;//笔记状态id
	private String cn_note_type_id;//笔记类型id
	private String cn_note_title;//笔记标题
	private String cn_note_body;//笔记内容
	private Long cn_note_create_time;//笔记创建时间
	private Long cn_note_last_modify_time;//笔记最终修改时间

	public String getCn_note_id() {
		return cn_note_id;
	}

	public void setCn_note_id(String cnNoteId) {
		cn_note_id = cnNoteId;
	}

	public String getCn_notebook_id() {
		return cn_notebook_id;
	}

	public void setCn_notebook_id(String cnNotebookId) {
		cn_notebook_id = cnNotebookId;
	}

	public String getCn_user_id() {
		return cn_user_id;
	}

	public void setCn_user_id(String cnUserId) {
		cn_user_id = cnUserId;
	}

	public String getCn_note_status_id() {
		return cn_note_status_id;
	}

	public void setCn_note_status_id(String cnNoteStatusId) {
		cn_note_status_id = cnNoteStatusId;
	}

	public String getCn_note_title() {
		return cn_note_title;
	}

	public void setCn_note_title(String cnNoteTitle) {
		cn_note_title = cnNoteTitle;
	}

	public String getCn_note_body() {
		return cn_note_body;
	}

	public void setCn_note_body(String cnNoteBody) {
		cn_note_body = cnNoteBody;
	}

	public Long getCn_note_create_time() {
		return cn_note_create_time;
	}

	public void setCn_note_create_time(Long cnNoteCreateTime) {
		cn_note_create_time = cnNoteCreateTime;
	}

	public Long getCn_note_last_modify_time() {
		return cn_note_last_modify_time;
	}

	public void setCn_note_last_modify_time(Long cnNoteLastModifyTime) {
		cn_note_last_modify_time = cnNoteLastModifyTime;
	}

	public String getCn_note_type_id() {
		return cn_note_type_id;
	}

	public void setCn_note_type_id(String cnNoteTypeId) {
		cn_note_type_id = cnNoteTypeId;
	}

}

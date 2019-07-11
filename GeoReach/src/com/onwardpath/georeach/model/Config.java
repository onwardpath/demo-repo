package com.onwardpath.georeach.model;

public class Config {
	private int id;	
	private int experience_id;
	private String url;
	private int user_id;
	private String create_time;
	
	
	public Config() {}
	
	public Config(int id, String url, int experience_id) {
		setId(id);
		setExperience_id(experience_id);
		setUrl(url);		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getExperience_id() {
		return experience_id;
	}
	public void setExperience_id(int experience_id) {
		this.experience_id = experience_id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getUserId() {
		return user_id;
	}
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
	public String getCreate_Time() {
		return create_time;
	}
	public void setCreateTime(String create_time) {
		this.create_time = create_time;
	}
}

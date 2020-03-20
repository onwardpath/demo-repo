package com.onwardpath.georeach.model;

public class Analytics {
	
	private int id; 
	private int site_id;
	private String site_name;
	private String root_domain; //setOrganization_domain
	private String urls;
	
	
	public Analytics()
	{
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getSite_name() {
		return site_name;
	}
	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}
	public String getRoot_domain() {
		return root_domain;
	}
	public void setRoot_domain(String root_domain) {
		this.root_domain = root_domain;
	}
	public String getUrls() {
		return urls;
	}
	public void setUrls(String urls) {
		this.urls = urls;
	}

}

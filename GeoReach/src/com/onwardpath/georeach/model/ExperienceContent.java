package com.onwardpath.georeach.model;

public class ExperienceContent {
	private String experienceName;
	private int id;
	private String segmentName;
	private String content;
	private String type;
	private String checkboxvalue;
	private String popupText;
	public String getPopupText() {
		return popupText;
	}
	public void setPopupText(String popupText) {
		this.popupText = popupText;
	}
	public String getPopupTime() {
		return popupTime;
	}
	public void setPopupTime(String popupTime) {
		this.popupTime = popupTime;
	}
	private String popupTime;
	
	public String getCheckboxvalue() {
		return checkboxvalue;
	}
	public void setCheckboxvalue(String checkboxvalue) {
		this.checkboxvalue = checkboxvalue;
	}
	
	public String getExperienceName() {
		return experienceName;
	}
	public void setExperienceName(String experienceName) {
		this.experienceName = experienceName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSegmentName() {
		return segmentName;
	}
	public void setSegmentName(String segmentName) {
		this.segmentName = segmentName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	

}

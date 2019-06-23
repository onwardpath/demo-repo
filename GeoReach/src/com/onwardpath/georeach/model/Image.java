package com.onwardpath.georeach.model;

public class Image {
	private int id;
	private int experience_id;
	private int segment_id;
	private String segment_name;
	private String url;
	private String create_time;	//TODO: Need to convert to appropriate date type/format
	
	public Image() {		
	}
	
	public Image(int id) {
		this.id = id;
	}
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the experience_id
	 */
	public int getExperience_id() {
		return experience_id;
	}
	/**
	 * @param experience_id the experience_id to set
	 */
	public void setExperience_id(int experience_id) {
		this.experience_id = experience_id;
	}
	/**
	 * @return the segment_id
	 */
	public int getSegment_id() {
		return segment_id;
	}
	/**
	 * @param segment_id the segment_id to set
	 */
	public void setSegment_id(int segment_id) {
		this.segment_id = segment_id;
	}
	/**
	 * @return the segment_name
	 */
	public String getSegmentName() {
		return segment_name;
	}
	/**
	 * @param segment_name the segment_name to set
	 */
	public void setSegmentName(String segment_name) {
		this.segment_name = segment_name;
	}
	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * @return the create_time
	 */
	public String getCreate_time() {
		return create_time;
	}
	/**
	 * @param create_time the create_time to set
	 */
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
}

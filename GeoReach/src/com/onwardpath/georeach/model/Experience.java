package com.onwardpath.georeach.model;

public class Experience {
	private int id;
	private String name;
	private String type;
	private String status;
	private String schedule_start; 	//TODO: Need to convert to appropriate date type/format
	private String schedule_end;	//TODO: Need to convert to appropriate date type/format
	private String header_code;
	private String body_code;	
	private int org_id;	
	private int user_id;
	private String create_time;		//TODO: Need to convert to appropriate date type/format
	
	public Experience (int id, String name, String type, String status, String schedule_start, String schedule_end, String header_code, String body_code, int org_id, int user_id, String create_time) {
		this.id = id;
		this.name = name;
		this.type = type;
		this.status = status;
		this.schedule_start = schedule_start;
		this.schedule_end = schedule_end;
		this.header_code = header_code;
		this.body_code = body_code;
		this.org_id = org_id;
		this.user_id = user_id;
		this.create_time = create_time;
	}
	
	public Experience (int id) {
		this.id = id;
	}
	
	public Experience() {		
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
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the schedule_start
	 */
	public String getSchedule_start() {
		return schedule_start;
	}

	/**
	 * @param schedule_start the schedule_start to set
	 */
	public void setSchedule_start(String schedule_start) {
		this.schedule_start = schedule_start;
	}

	/**
	 * @return the schedule_end
	 */
	public String getSchedule_end() {
		return schedule_end;
	}

	/**
	 * @param schedule_end the schedule_end to set
	 */
	public void setSchedule_end(String schedule_end) {
		this.schedule_end = schedule_end;
	}

	/**
	 * @return the header_code
	 */
	public String getHeader_code() {
		return header_code;
	}

	/**
	 * @param header_code the header_code to set
	 */
	public void setHeader_code(String header_code) {
		this.header_code = header_code;
	}

	/**
	 * @return the body_code
	 */
	public String getBody_code() {
		return body_code;
	}

	/**
	 * @param body_code the body_code to set
	 */
	public void setBody_code(String body_code) {
		this.body_code = body_code;
	}

	/**
	 * @return the org_id
	 */
	public int getOrg_id() {
		return org_id;
	}

	/**
	 * @param org_id the org_id to set
	 */
	public void setOrg_id(int org_id) {
		this.org_id = org_id;
	}

	/**
	 * @return the user_id
	 */
	public int getUser_id() {
		return user_id;
	}

	/**
	 * @param user_id the user_id to set
	 */
	public void setUser_id(int user_id) {
		this.user_id = user_id;
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

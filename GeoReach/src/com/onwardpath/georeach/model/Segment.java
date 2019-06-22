package com.onwardpath.georeach.model;

public class Segment {
	private int id;
	private String name;
	private String geography;	
	private int org_id;				//Segment is available for this organization
	private int user_id; 			//Creator of this segment
	
	//TODO: Include updated_by, create_date, update_date, status (Enabled/Disabled)
	
	public Segment (int id, String name, String geography, int org_id, int user_id) {
		this.id = id;
		this.name = name;
		this.geography = geography;
		this.org_id = org_id;
		this.user_id = user_id;		
	}
	
	public Segment (int id) {
		this.id = id;
	}
	
	public Segment() {		
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
	public String getGeography() {
		return geography;
	}

	/**
	 * @param type the type to set
	 */
	public void setGeography(String geography) {
		this.geography = geography;
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
}
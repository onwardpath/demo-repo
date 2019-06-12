package com.onwardpath.georeach.model;

public class Org {
	private static int id;
	private static String name;
	private static String domain;
	private static String logo;
	
	public static int getId() {
		return id;
	}
	public static void setId(int id) {
		Org.id = id;
	}
	public static String getName() {
		return name;
	}
	public static void setName(String name) {
		Org.name = name;
	}
	public static String getDomain() {
		return domain;
	}
	public static void setDomain(String domain) {
		Org.domain = domain;
	}
	public static String getLogo() {
		return logo;
	}
	public static void setLogo(String logo) {
		Org.logo = logo;
	}	
}

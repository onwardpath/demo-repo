package com.onwardpath.georeach.model;

public class User {
	private static int id; 
	private static int organization_id;
	private static String firstname;
	private static String lastname;
	private static String gender;
	private static String email;
	private static String phone1;
	private static String phone2;
	private static String login;
	private static String password;
	private static int role_id;
	public static int getId() {
		return id;
	}
	public static void setId(int id) {
		User.id = id;
	}
	public static int getOrganization_id() {
		return organization_id;
	}
	public static void setOrganization_id(int organization_id) {
		User.organization_id = organization_id;
	}
	public static String getFirstname() {
		return firstname;
	}
	public static void setFirstname(String firstname) {
		User.firstname = firstname;
	}
	public static String getLastname() {
		return lastname;
	}
	public static void setLastname(String lastname) {
		User.lastname = lastname;
	}
	public static String getGender() {
		return gender;
	}
	public static void setGender(String gender) {
		User.gender = gender;
	}
	public static String getEmail() {
		return email;
	}
	public static void setEmail(String email) {
		User.email = email;
	}
	public static String getPhone1() {
		return phone1;
	}
	public static void setPhone1(String phone1) {
		User.phone1 = phone1;
	}
	public static String getPhone2() {
		return phone2;
	}
	public static void setPhone2(String phone2) {
		User.phone2 = phone2;
	}
	public static String getLogin() {
		return login;
	}
	public static void setLogin(String login) {
		User.login = login;
	}
	public static String getPassword() {
		return password;
	}
	public static void setPassword(String password) {
		User.password = password;
	}
	public static int getRole_id() {
		return role_id;
	}
	public static void setRole_id(int role_id) {
		User.role_id = role_id;
	}
	
}

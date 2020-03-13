package com.onwardpath.georeach.repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.onwardpath.georeach.util.Database;
import com.onwardpath.georeach.util.GlobalConfig;
import com.onwardpath.georeach.util.MatomoUtil;

/**
 * Allows Insert, Update and Delete Matomo websites & Users Methods: save, edit,
 * load
 * 
 * @author Gurujegan
 * @date 05 Mar 2020
 *
 */

public class MatomoRepository {

	String MATAMO_SERVER_URL = "";
	String MODULE = "";
	String METHOD = "";
	String IDSITE = "";
	String FORMAT = "JSON";
	String TOKEN_AUTH = "";
	String SITENAME = "";
	String DOMAIN_URL = "";
	final String _AMPERSAND = "&";
	String INITIAL_ID_SITE = "";
	String USER_LOGIN = "";
	String EMAIL = "";
	String PASSWORD = "";
	private Connection dbConnection;

	public MatomoRepository() throws IOException {
		dbConnection = Database.getConnection();
		GlobalConfig gc = GlobalConfig.getInstance();
		Properties properties = gc.properties;
		MATAMO_SERVER_URL = properties.getProperty("matomo_url");
		TOKEN_AUTH = properties.getProperty("matomo_token_auth");
	}

	/**
	 * Generate HTTP qualified URL to execute
	 * 
	 * @param API Module
	 * @return User
	 * @throws SQLException
	 */
	private String getSiteReportURL(String module, String method, String idSite) throws IOException {
		this.MODULE = "module=" + module + _AMPERSAND;
		this.METHOD = "method=" + method + _AMPERSAND;
		this.IDSITE = "idSite=" + idSite + _AMPERSAND;
		String fullURL = MATAMO_SERVER_URL + MODULE + METHOD + IDSITE + "format=" + FORMAT + "&token_auth="
				+ TOKEN_AUTH;
		return fullURL;
	}

	private String getAddWebsiteURL(String module, String method, String sitename, String domain_url)
			throws IOException {

		this.MODULE = "module=" + module + _AMPERSAND;
		this.METHOD = "method=" + method + _AMPERSAND;
		this.SITENAME = "siteName=" + sitename + _AMPERSAND;
		this.DOMAIN_URL = "urls[0]=" + domain_url + _AMPERSAND;

		String excludeUnknownUrls = "excludeUnknownUrls=1" + _AMPERSAND;
		String type = "type=website" + _AMPERSAND;
		String fullURL = MATAMO_SERVER_URL + MODULE + METHOD + SITENAME + DOMAIN_URL + excludeUnknownUrls + type
				+ "format=" + FORMAT + "&token_auth=" + TOKEN_AUTH;
		return fullURL;
	}

	private String getAddUserURL(String module, String method, String initialIdSite, String userLogin, String password,
			String email) throws IOException {

		this.MODULE = "module=" + module + _AMPERSAND;
		this.METHOD = "method=" + method + _AMPERSAND;
		this.INITIAL_ID_SITE = "siteName=" + initialIdSite + _AMPERSAND;
		this.USER_LOGIN = "userLogin=" + userLogin + _AMPERSAND;
		this.PASSWORD = "password=" + password + _AMPERSAND;
		this.EMAIL = "email=" + password + _AMPERSAND;

		String fullURL = MATAMO_SERVER_URL + MODULE + METHOD + INITIAL_ID_SITE + USER_LOGIN + PASSWORD + EMAIL
				+ "format=" + FORMAT + "&token_auth=" + TOKEN_AUTH;
		return fullURL;
	}

	/**
	 * Add website into Matomo in order to track
	 * 
	 * @param orgName
	 * @param domain
	 * @return siteID
	 * 
	 */
	public int registerWebsite(String orgName, String domain) {

		int analytics_id = 0;
		final String http_x_URL;
		final String rsJsonfromURL;
		JsonObject resultjson = null;
		String res_siteID = null;

		try {

			if ((orgName != null && domain != null)) {
				http_x_URL = getAddWebsiteURL("API", "SitesManager.addSite", orgName, domain);
				rsJsonfromURL = getJSONfromURL(http_x_URL);
				System.out.println("Result JSON length" + rsJsonfromURL);
				if (!(rsJsonfromURL.equals("{}") || rsJsonfromURL.equals("[]"))
						&& !(rsJsonfromURL.equalsIgnoreCase("error"))) {
					Gson gson = new Gson();
					System.out.println(http_x_URL);
					JsonElement jelement = gson.fromJson(rsJsonfromURL, JsonElement.class);
					resultjson = jelement.getAsJsonObject();
					if ((resultjson.get("value") != null)) {
						res_siteID = resultjson.get("value").toString();
						System.out.println("Matomo created Site ID:" + res_siteID);
						analytics_id = saveSiteInfo(res_siteID, getRootDomain(domain));
					} else {
						analytics_id = 0;
					}
				}

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return analytics_id;

	}

	/**
	 * Save collected matomo information into analytics table & return row id
	 * 
	 * @param siteID
	 * @param root_domain
	 * @return rowID
	 * 
	 */

	private int saveSiteInfo(String siteID, String root_domain) throws IOException {

		int row_id = 0;
		String sitename = null;
		String urls = null;
		final String http_x_URL;
		final String rsJsonfromURL;

		JsonObject resultjson = null;
		JsonArray resultArray = null;

		http_x_URL = getSiteReportURL("API", "SitesManager.getSiteFromId", siteID);
		System.out.println("http_x_URL" + http_x_URL);
		rsJsonfromURL = getJSONfromURL(http_x_URL);
		System.out.println("MatomoReposiroty.saveSiteInfo>getSiteInfo by URL:" + http_x_URL);

		if (!(rsJsonfromURL.equals("{}") || rsJsonfromURL.equals("[]"))) {
			Gson gson = new Gson();
			JsonElement jelement = gson.fromJson(rsJsonfromURL, JsonElement.class);
			if (!jelement.isJsonArray())
				throw new IllegalArgumentException("json is not an array");
			final JsonArray array = jelement.getAsJsonArray();

			for (JsonElement je : array) {
				final JsonObject dtObj = je.getAsJsonObject();
				sitename = dtObj.get("name").getAsString();
				urls = dtObj.get("main_url").getAsString();
			}

			/*
			 * array.forEach((item) -> { if (item.isJsonObject()) { final JsonObject dtObj =
			 * item.getAsJsonObject(); sitename = dtObj.get("name").getAsString(); urls =
			 * dtObj.get("main_url").getAsString(); // System.out.println(key +":"+type); }
			 * });
			 */

			try {
				if (array.size() > 0) {
					PreparedStatement prepStatement = dbConnection.prepareStatement(
							"insert into analytics (siteid, sitename,root_domain, urls) values  (?, ?, ?, ?)");
					prepStatement.setString(1, siteID);
					prepStatement.setString(2, sitename);
					prepStatement.setString(3, root_domain);
					prepStatement.setString(4, urls);

					System.out.println(Database.getTimestamp() + " @MatomoReposiroty.saveSiteInfo>prepStatement: "
							+ prepStatement.toString());
					prepStatement.executeUpdate();
					// Get the inserted row id
					prepStatement = dbConnection.prepareStatement("select last_insert_id()");
					System.out.println(Database.getTimestamp() + " @MatomoRepository.saveSiteInfo>prepStatement1: "
							+ prepStatement.toString());
					ResultSet rs = prepStatement.executeQuery();
					rs.next();
					row_id = rs.getInt(1);
					prepStatement.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return row_id;

	}

	/**
	 * @throws IOException Add website into Matomo in order to track
	 * 
	 * 
	 */
	public String registerNewUser() throws IOException {

		String http_x_URL;
		String rsJsonfromURL;
		JsonObject resultjson = null;

		System.out.println(getAddUserURL("API", "UsersManager.addUser", "10", "user1", "pwd", "email"));

		return null;

	}

	/**
	 * 
	 * @throws MalformedURLException
	 * @param domain
	 * 
	 * Domain val should contain www in the start Eg: http://www.google.com
	 */
	
	public String getRootDomain(String domain) throws MalformedURLException {

		String root_domain = null;
		String fq_domain = null; // fully qualified domain
		final URL u = new URL(domain);
		fq_domain = u.getHost();
		if (u.getHost().contains(("www"))) {
			root_domain = fq_domain.split("www.")[1];
		} else {
			int beginIndex = u.getHost().indexOf(".") + 1;
			root_domain = fq_domain.substring(beginIndex, fq_domain.length());
		}
		return root_domain;

	}

	/**
	 * Check if an Organization exists based on domain
	 * 
	 * @param domain
	 * @return boolean
	 */
	public int getRowIdbyRootDomain(String root_domain) throws SQLException {
		int analytics_id = 0;
		PreparedStatement prepStatement = dbConnection
				.prepareStatement("select id from analytics where root_domain = ?");
		prepStatement.setString(1, root_domain);
		System.out.println(
				Database.getTimestamp() + " @UserRepository.orgExists>prepStatement: " + prepStatement.toString());
		ResultSet result = prepStatement.executeQuery();
		if (result != null) {
			while (result.next()) {
				analytics_id = result.getInt(1);
			}
		}
		prepStatement.close();
		result.close();
		return analytics_id;
	}

	/**
	 * Convert JSON response to String from URL response
	 * 
	 * @param fullURL
	 * @return String
	 */

	public static String getJSONfromURL(String fullURL) {
		StringBuilder responseJson = null;
		try {

			URL obj = new URL(fullURL);
			HttpURLConnection connection = (HttpURLConnection) obj.openConnection();
			int responseCode = connection.getResponseCode();

			System.out.println("Response code" + responseCode);
			InputStream inputStream;

			if (200 <= responseCode && responseCode <= 299) {
				inputStream = connection.getInputStream();
				BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));
				responseJson = new StringBuilder();
				String currentLine;

				while ((currentLine = in.readLine()) != null) {
					responseJson.append(currentLine);
				}
				in.close();

			} else {
				inputStream = connection.getErrorStream();
				responseJson = new StringBuilder();
				responseJson.append("error");
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return responseJson.toString();

	}

}

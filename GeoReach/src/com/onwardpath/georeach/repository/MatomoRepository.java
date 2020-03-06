package com.onwardpath.georeach.repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.util.Properties;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
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
	String INITIAL_ID_SITE="";
	String USER_LOGIN = "";
	String EMAIL = "";
	String PASSWORD = "";
	

	public MatomoRepository() throws IOException {
		GlobalConfig gc = GlobalConfig.getInstance();
		Properties properties = gc.properties;
		MATAMO_SERVER_URL = properties.getProperty("matomo_url");
		TOKEN_AUTH = properties.getProperty("matomo_token_auth");
	}

	/**
	 * Get User object will all user details loaded
	 * 
	 * @param API Module
	 * @return User
	 * @throws SQLException
	 */
	private String getSiteReportURL(String module, String method, String idSite) throws IOException {
		this.MODULE = "module=" + module + "&";
		this.METHOD = "method=" + method + "&";
		this.IDSITE = "idSite=" + idSite + "&";
		String fullURL = MATAMO_SERVER_URL + module + method + idSite + "format=" + FORMAT + "&token_auth="
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
	
	private String getAddUserURL(String module, String method, String initialIdSite, String userLogin, String password, String email)
			throws IOException {

		this.MODULE = "module=" + module + _AMPERSAND;
		this.METHOD = "method=" + method + _AMPERSAND;
		this.INITIAL_ID_SITE = "siteName=" + initialIdSite + _AMPERSAND;
		this.USER_LOGIN = "userLogin=" + userLogin + _AMPERSAND;
		this.PASSWORD = "password=" + password + _AMPERSAND;
		this.EMAIL= "email=" + password + _AMPERSAND;

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
	 * @throws 
	 */
	public String registerWebsite(String orgName, String domain) {

		String http_x_URL;
		String rsJsonfromURL;
		JsonObject resultjson = null;

		try {

			if ((orgName != null && domain != null)) {
				http_x_URL = getAddWebsiteURL("API", "SitesManager.addSite", orgName, domain);
				rsJsonfromURL = getJSONfromURL(http_x_URL);
				if (!(rsJsonfromURL.equals("{}") || rsJsonfromURL.equals("[]"))) {
					Gson gson = new Gson();
					JsonElement jelement = gson.fromJson(rsJsonfromURL, JsonElement.class);
					resultjson = jelement.getAsJsonObject();
					if ((resultjson.get("value") != null)) {
						String res = resultjson.get("value").toString();
						System.out.println("Matomo created Site ID:" + res);
					}
				}

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return resultjson.toString();

	}
	
	
	/**
	 * @throws IOException 
	 * Add website into Matomo in order to track
	 * 
	 * @param orgName
	 * @param domain
	 * @return siteID
	 * @throws 
	 */
	public String registerNewUser() throws IOException {

		String http_x_URL;
		String rsJsonfromURL;
		JsonObject resultjson = null;

	
		System.out.println(getAddUserURL("API","UsersManager.addUser","10","user1","pwd","email"));		
		
		
		return null;

	}
	

	public static String getJSONfromURL(String fullURL) {
		StringBuilder responseJson = null;
		try {

			URL obj = new URL(fullURL);
			HttpURLConnection connection = (HttpURLConnection) obj.openConnection();
			int responseCode = connection.getResponseCode();
			InputStream inputStream;

			if (200 <= responseCode && responseCode <= 299) {
				inputStream = connection.getInputStream();
			} else {
				inputStream = connection.getErrorStream();
			}

			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));
			responseJson = new StringBuilder();
			String currentLine;

			while ((currentLine = in.readLine()) != null) {
				responseJson.append(currentLine);
			}

			in.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return responseJson.toString();

	}

}

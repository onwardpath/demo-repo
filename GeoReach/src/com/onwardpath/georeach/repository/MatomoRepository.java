package com.onwardpath.georeach.repository;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;

import com.onwardpath.georeach.util.GlobalConfig;
import com.onwardpath.georeach.util.MatomoUtil;

/**
 * Allows Insert, Update and Delete Matomo websites & Users 
 * Methods: save, edit,
 * load
 * 
 * @author Gurujegan
 * @date 05 Mar 2020
 *
 */

public class MatomoRepository {

	String url = "";
	String module = "";
	String method = "";
	String idSite = "";
	String format = "JSON";
	String token_auth = "";
	public static String fullURL;

	public MatomoRepository() throws IOException {
		GlobalConfig gc = GlobalConfig.getInstance();
		Properties properties = gc.properties;
		url = properties.getProperty("matomo_url");
		token_auth = properties.getProperty("matomo_token_auth");
		System.out.println("fullurl" + getHttpApiUrl("Dfdsfs","Sdfsfs","34"));
	}

	
	  /**
	   * Get User object will all user details loaded
	   * 
	   * @param API Module
	   * @return User 
	   * @throws SQLException
	   */
    private String getHttpApiUrl(String module, String method, String idSite) throws IOException {
    	module = "module=" + module + "&";
    	method = "method=" + method + "&";
        idSite = "idSite=" + idSite + "&";
        fullURL = url + module + method + idSite + "format=" + format + "&token_auth=" + token_auth;
        return fullURL;
    }
    
    
	public void registerWebsite()
	{
		
	}
	
	
	
}

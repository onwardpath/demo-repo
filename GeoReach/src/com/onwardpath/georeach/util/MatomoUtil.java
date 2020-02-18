/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.onwardpath.georeach.util;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;


/**
 *
 * @author Gurujegan
 */
public class MatomoUtil {

	private static String url="";
    private static String module = "";
    private static String method = "";
    private static String idSite = "";
    private static String format = "JSON";
    private static String token_auth="";

    
    public MatomoUtil()
    {
    	GlobalConfig gc = GlobalConfig.getInstance();
    	Properties properties = gc.properties;
    	MatomoUtil.url = properties.getProperty("matomo_url");
    	MatomoUtil.token_auth = properties.getProperty("matomo_token_auth");
    	System.out.println("fullurl"+MatomoUtil.url);
    }
   
   /* public static String getVisitorDurationLog(String attribName) throws IOException {
        String URL = getHttpApiUrl("API", "Live.getVisitorProfile", "1");
        System.out.println(URL);
        String rsJsonfromURL = getLocationDetails(URL);
         String rsJsonStr = null;
         System.out.println("Matomo log:"+rsJsonfromURL);
        if(rsJsonfromURL.length() > 2)
        {
        Gson gson = new Gson();
        JsonElement jelement = gson.fromJson(rsJsonfromURL, JsonElement.class);
        JsonObject resultjson = jelement.getAsJsonObject();
        rsJsonStr = resultjson.get(attribName).toString();
        }
        return rsJsonStr;
    } */

    public static String getHttpApiUrl(String module, String method, String idSite) throws IOException {
        MatomoUtil.module = "module=" + module + "&";
        MatomoUtil.method = "method=" + method + "&";
        MatomoUtil.idSite = "idSite=" + idSite + "&";
        String fullURL;
        fullURL = MatomoUtil.url + MatomoUtil.module + MatomoUtil.method + MatomoUtil.idSite + "format=" + MatomoUtil.format + "&token_auth=" + token_auth;
        return fullURL;
    }
    
    /* public static String getVisitorType(String arrayAttribute,String attribName) throws IOException {
        String URL = getHttpApiUrl("API", "Live.getVisitorProfile", "1");
        String rsJsonfromURL = getLocationDetails(URL);
        String rsJsonStr = null;
        System.out.println(rsJsonfromURL.length());
        Gson gson = new Gson();
        if(rsJsonfromURL.length() > 2)
        {
        JsonElement jelement = gson.fromJson(rsJsonfromURL, JsonElement.class);
        JsonObject jobject = jelement.getAsJsonObject();
        System.out.println("Mataomo getvisitorprofile details jsonobject::"+jobject);
        JsonArray jarray  = jobject.getAsJsonArray("lastVisits");
        jobject = jarray.get(0).getAsJsonObject();
        rsJsonStr = jobject.get(attribName).toString().replaceAll("\"", "");
        }
       
        return rsJsonStr;
    } */
    
    //This method helps to getting & serving JSON response from the URL 
    public static String getLocationDetails(String fullURL) {
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

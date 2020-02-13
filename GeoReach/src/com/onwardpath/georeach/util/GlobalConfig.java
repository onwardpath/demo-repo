package com.onwardpath.georeach.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.Properties;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Gurujegan
 */
public class GlobalConfig {
	
	public Properties properties; 
	private GlobalConfig(){
	  	 InputStream inputStream = GlobalConfig.class.getClassLoader().getResourceAsStream("config.properties");
         properties = new Properties();
         try {
        	properties.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static class ConfigHolder {
		private static GlobalConfig gc = new GlobalConfig();
	}

	 public static GlobalConfig getInstance() {
	        return ConfigHolder.gc;
	    }
 

}
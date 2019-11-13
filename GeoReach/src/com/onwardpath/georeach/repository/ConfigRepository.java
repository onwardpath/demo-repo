package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.HashMap;
import com.onwardpath.georeach.model.Config;
import com.onwardpath.georeach.util.Database;


public class ConfigRepository {
	private Connection dbConnection;
	
	public ConfigRepository() {
		dbConnection = Database.getConnection();
	}
	
	public void delete(int experience_id) throws SQLException{
		PreparedStatement prepStatement = dbConnection.prepareStatement("delete from georeachdb.config where experience_id =?");
		prepStatement.setInt(1, experience_id);
        System.out.println(Database.getTimestamp()+" @ExperienceRepository.save>prepStatement: "+prepStatement.toString());
        prepStatement.executeUpdate();
         prepStatement.close();       
	}
	public int save(int experience_id, String url, int user_id) throws SQLException{
		PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.config (experience_id, url, user_id, create_time) values (?,?,?, now())");
		prepStatement.setInt(1, experience_id);
        prepStatement.setString(2, url);       
        prepStatement.setInt(3, user_id);
        System.out.println(Database.getTimestamp()+" @ExperienceRepository.save>prepStatement: "+prepStatement.toString());
        prepStatement.executeUpdate();
        prepStatement = dbConnection.prepareStatement("select last_insert_id()");
        ResultSet result = prepStatement.executeQuery();          
        result.next();
        int id = result.getInt(1);           
        prepStatement.close();
        result.close();
        return id;
	}
}

package com.onwardpath.georeach.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.xml.bind.DatatypeConverter;
 
public class SHAHashing {
     
    public static void main(String[] args) throws NoSuchAlgorithmException 
    {
        
    }
    //Signup password with hashkey
    public String signup(String password) throws NoSuchAlgorithmException
    {
    	byte[] salts = getSalt();
    	
         
        String passwordToHash = salts+password;
        String securePassword = get_SHA_1_SecurePassword(passwordToHash);
       
        String saltedpassword = salts+"/"+securePassword;
        System.out.println("signupsecurepassword=="+saltedpassword);
        return saltedpassword;
    }
    
    //Login password to retrieve exact password
    public String login(String password,String salt) throws NoSuchAlgorithmException
    {
    	
        String login_salt = salt;
        System.out.println("login salt"+login_salt);
       
        String passwordToHash = login_salt+password;
     
        String securePassword = get_SHA_1_SecurePassword(passwordToHash);
        System.out.println("loginsecurepassword=="+securePassword);
        return securePassword;
    }
    private static String get_SHA_1_SecurePassword(String passwordToHash)
    {
        String generatedPassword = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            
            
            byte[] bytes = md.digest(passwordToHash.getBytes());
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            generatedPassword = sb.toString();
            System.out.println("generatedPassword=="+generatedPassword);
        } 
        catch (NoSuchAlgorithmException e) 
        {
            e.printStackTrace();
        }
        return generatedPassword;
    }
    //Add salt
    private static byte[] getSalt() throws NoSuchAlgorithmException
    {
    	SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
        byte[] salt = new byte[16];
        random.nextBytes(salt); 
        System.out.println("salts="+salt); 
        
        return salt;
    }
}

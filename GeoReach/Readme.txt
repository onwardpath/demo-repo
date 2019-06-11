Read-me file for GeoReach project

DEVELOPER SETUP:

1. Install JDK 8 to C:\Java\
	https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
	jdk-8u211-windows-x64.exe
	Install JDK to C:\Java\jdk1.8.0_211 and JRE to C:\Java\jre1.8.0_211
	Confirm installation from CMD prompt:
	C:\Users\pandyan>java -fullversion
	java full version "1.8.0_211-b12"

2. Install Eclipse to C:\Eclipse
	Eclipse JEE Neon

3. Install Tomcat to C:\Tomcat
	Version 9.0.20 (64 bit Windows Zip)
	apache-tomcat-9.0.20-windows-x64.zip
	Configure Tomcat Server in Eclipse

4: Configure GIT
http://www.geo.uzh.ch/microsite/reproducible_research/post/rr-eclipse-git/

At this point your installations should looks like this:
C:\Java\
	jdk1.8.0_211\
	jre1.8.0_211\
C:\Eclipse\
	jee-neon\
	workspace\
C:\Tomcat\
	apache-tomcat-9.0.20\

Optional:
Install MySQL Server (mysql-installer-web-community-8.0.16.0)
	TCP/IP Port: 3306
	X Protocol Port: 33060
	MySQL Root Password: onwardAdmin1
	User Name: onwardDev
	Password: onwardDev1
Download MySQL Connector/J Platform Independent Version(https://dev.mysql.com/downloads/connector/j/)

Optional Install GitBash (Git-2.21.0-64-bit from https://git-scm.com/download/win)

DEVELOPER TUTORIALS:
Java SE 8: Creating a Web App with Bootstrap and Tomcat Embedded
https://www.oracle.com/webfolder/technetwork/tutorials/obe/java/basic_app_embedded_tomcat/basic_app-tomcat-embedded.html



DATABASE SCHEMA:

MySQL Reference:
https://chartio.com/resources/tutorials/understanding-strorage-sizes-for-mysql-text-data-types/

ORGANIZATION
	id (PK)
	name
	domain
	logo

USER
	id
	org_id (FK)
	firstname
	lastname
	gender
	email
	phone1
	phone2
	login
	password
	role_id (FK)

ROLES
	id
	role
	
SEGMENT
	id
	name
	geography (format: "in-city:San Jose|in-city:Santa Clara|in-State:NV|ex-city:Las Vegas-NV")
	user_id (FK - creator of this segment)
	org_id (FK - org this segment will be used and be visible)
	

SQL SCRIPTS:
CREATE SCHEMA `georeachdb` ;

CREATE TABLE `georeachdb`.`organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `domain` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `georeachdb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `org_id` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone1` VARCHAR(45) NULL,
  `phone2` VARCHAR(45) NULL,
  `login` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `georeachdb`.`user` 
ADD INDEX `org_id` (`org_id` ASC) VISIBLE;

ALTER TABLE `georeachdb`.`user` 
ADD CONSTRAINT `org_id_fk`
  FOREIGN KEY (`org_id`)
  REFERENCES `georeachdb`.`organization` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE TABLE `georeachdb`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `georeachdb`.`user` 
ADD INDEX `role_id` (`role_id` ASC) VISIBLE;

ALTER TABLE `georeachdb`.`user` 
ADD CONSTRAINT `role_id_fk`
  FOREIGN KEY (`role_id`)
  REFERENCES `georeachdb`.`role` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE TABLE `georeachdb`.`segment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `geography` TEXT(5000) NULL,
  `user_id` INT NOT NULL,
  `org_id` INT NOT NULL,
  PRIMARY KEY (`id`));
  
INSERT INTO georeachdb.ORGANIZATION (name,domain,logo) VALUES ('ACME INC','acmeinc.com','http://acmeinc.com/logo.gif');
INSERT INTO georeachdb.ROLE (name) VALUES ('Administrator');
INSERT INTO georeachdb.ROLE (name) VALUES ('User');
INSERT INTO georeachdb.USER (org_id,firstname,lastname,gender,email,phone1,phone2,login,password,role_id) VALUES (1,'Mark','Antony','M','mantony@acmeinc.com','9205300006','','mantony@acmeinc.com','pass123',1);

select * from georeachdb.organization;
select * from georeachdb.role;
select * from georeachdb.user;
select * from georeachdb.segment;

GIT:

Signin to GitHub.com with your onwardpath email
Install GitBash (Git-2.21.0-64-bit from https://git-scm.com/download/win)

Start GitBash
$ git config --global user.name "pandyan"
$ git config --global user.email "pandyans@onwardpath.com"

From Eclipse, specify your GIT Repository as follows:
Eclipse> Project > Team > Share
C:\Users\Pandyan\git\repository

$ git cd GeoReach
After you have made changes to your code
$ git status
Will list changes
$ git add <name of file with changes>
$ git commit -m "<brief description of what changed>"
$ git remote add origin https://github.com/onwardpath/demo-repo.git
$ git remote -v
$ git push --set-upstream origin master
After making code changes use the following command to push to origin/Online-Repo
$ git push

More info: https://readwrite.com/2013/09/30/understanding-github-a-journey-for-beginners-part-1/

NOTES:

GEO IP SERVICES:
https://dev.maxmind.com/geoip/geoip2/downloadable/
https://ipinfo.io/
https://geoip-db.com/
https://www.geojs.io/ (Free)

https://neilpatel.com/blog/geo-targeting/ (Increase Conversions with Geo Targeting)
https://www.youtube.com/watch?v=zQbMmzXclik (Get users ip, city, country, location etc using javascript and ipinfo.io)
https://stackoverflow.com/questions/391979/how-to-get-clients-ip-address-using-javascript (How to get client's IP address using JavaScript)

GeoLocation: JavaScript can detect users geo location. This works for Smart Phone users. 
Hybrid (Uses Google GeoLocation and fallsback to IP Address based):
https://onury.io/geolocator/

Testing:
https://www.geoscreenshot.com/

Competition:
https://geotargetly.com/
https://geofli.com




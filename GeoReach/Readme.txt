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
http://www.mysqltutorial.org/basic-mysql-tutorial.aspx
https://chartio.com/resources/tutorials/understanding-strorage-sizes-for-mysql-text-data-types/
https://www.youtube.com/watch?v=0kaUwiygcfw

ORGANIZATION
	id (PK)
	name
	domain
	logo

USER
	id (PK)
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
	id (PK)
	role
	
SEGMENT
	id (PPK)
	name
	geography (format: "in-city:San Jose|in-city:Santa Clara|in-State:NV|ex-city:Las Vegas-NV")
	user_id (FK - creator of this segment)
	org_id (FK - org this segment will be used and be visible)
	
EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ID(PK) 	Name			Header-Code		Body-Code	Type		User_id(FK)		Org_id(FK)	Create-Time					Status			Schedule_start					Schedule_end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
001		Team-Aff-Img	<js src...		<div id..	Image		002				001			12-jun-2019 5:00 am CST		ON		
002		Team-Aff-Txt	<js src...		<div id..	Text		002				001			12-jun-2019 5:15 am CST		SC				21-Jun-2019 9:00 AM CST		21-Jun-2019 5:00 PM CST

IMAGE
----------------------------------------------------------------------------------
ID(PK)	E-ID(FK)	Segment(FK)		URL								Create-Time
----------------------------------------------------------------------------------
001		001			004				abc.com/gbpackers.jpg
002		001			005				abc.com/vikings.jpg

CONTENT
----------------------------------------------------------------------------------
ID(PK)	E-ID(FK)	Segment(PK)		Content							Create-Time
----------------------------------------------------------------------------------
001		002			004				Hello from Green Bay...
002		002			005				Hello from Minnieapolis...


SQL SCRIPTS:
CREATE SCHEMA `georeachdb` ;

CREATE TABLE `georeachdb`.`organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `domain` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `georeachdb`.`organization` 
ADD INDEX `id` (`id` ASC) VISIBLE;
;

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
;

ALTER TABLE `georeachdb`.`user` 
ADD CONSTRAINT `org_id_fk`
  FOREIGN KEY (`org_id`)
  REFERENCES `georeachdb`.`organization` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  ;

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
  
ALTER TABLE `georeachdb`.`segment` 
ADD INDEX `user_id` (`user_id` ASC) INVISIBLE,
ADD INDEX `org_id` (`org_id` ASC) VISIBLE;

ALTER TABLE `georeachdb`.`segment` 
ALTER TABLE `georeachdb`.`segment` 
ADD CONSTRAINT `s_org_id_fk`
  FOREIGN KEY (`org_id`)
  REFERENCES `georeachdb`.`organization` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `s_user_id_fk`
  FOREIGN KEY (`user_id`)
  REFERENCES `georeachdb`.`user` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE TABLE `georeachdb`.`experience` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `segment_id` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NULL,
  `code` VARCHAR(5000) NULL,
  `user_id` INT NULL,
  `org_id` INT NULL,
  `status` VARCHAR(45) NULL,
  `schedule_start` DATE NULL,
  `schedule_end` DATE NULL,
  PRIMARY KEY (`id`));
  
ALTER TABLE `georeachdb`.`experience` 
ADD INDEX `user_id` (`user_id` ASC) INVISIBLE,
ADD INDEX `org_id` (`org_id` ASC) VISIBLE;
;
  
ALTER TABLE `georeachdb`.`experience` 
ADD CONSTRAINT `e_org_id_fk`
  FOREIGN KEY (`org_id`)
  REFERENCES `georeachdb`.`organization` (`id`),
ADD CONSTRAINT `e_user_id_fk`
  FOREIGN KEY (`user_id`)
  REFERENCES `georeachdb`.`user` (`id`);


ALTER TABLE `georeachdb`.`experience` 
DROP COLUMN `segment_id`,
ADD COLUMN `type` VARCHAR(45) NULL AFTER `name`,
ADD COLUMN `create_time` DATETIME NULL AFTER `user_id`,
CHANGE COLUMN `status` `status` VARCHAR(45) NULL DEFAULT NULL AFTER `type`,
CHANGE COLUMN `schedule_start` `schedule_start` DATETIME NULL DEFAULT NULL AFTER `status`,
CHANGE COLUMN `schedule_end` `schedule_end` DATETIME NULL DEFAULT NULL AFTER `schedule_start`,
CHANGE COLUMN `org_id` `org_id` INT(11) NULL DEFAULT NULL AFTER `body_code`,
CHANGE COLUMN `url` `header_code` VARCHAR(5000) NULL DEFAULT NULL ,
CHANGE COLUMN `code` `body_code` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `georeachdb`.`experience` 
DROP FOREIGN KEY `e_org_id_fk`,
DROP FOREIGN KEY `e_user_id_fk`;
ALTER TABLE `georeachdb`.`experience` 
ADD CONSTRAINT `e_org_id_fk`
  FOREIGN KEY (`org_id`)
  REFERENCES `georeachdb`.`organization` (`id`)
  ON UPDATE CASCADE,
ADD CONSTRAINT `e_user_id_fk`
  FOREIGN KEY (`user_id`)
  REFERENCES `georeachdb`.`user` (`id`)
  ON DELETE CASCADE;

CREATE TABLE `georeachdb`.`image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `experience_id` INT NOT NULL,
  `segment_id` INT NOT NULL,
  `url` VARCHAR(500) NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `georeachdb`.`content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `experience_id` INT NOT NULL,
  `segment_id` INT NOT NULL,
  `content` TEXT(5000) NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `georeachdb`.`image` 
ADD INDEX `i-experience-id-fk` (`experience_id` ASC) VISIBLE;
;

ALTER TABLE `georeachdb`.`image` 
ADD INDEX `i-segment-id-fk` (`segment_id` ASC) VISIBLE;

ALTER TABLE `georeachdb`.`image` 
ADD CONSTRAINT `i_exp_id`
  FOREIGN KEY (`experience_id`)
  REFERENCES `georeachdb`.`experience` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
ALTER TABLE `georeachdb`.`image` 
ADD CONSTRAINT `i_seg_id`
  FOREIGN KEY (`segment_id`)
  REFERENCES `georeachdb`.`segment` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-----------------------------------------------------------------------------------------------
INSERT INTO georeachdb.ORGANIZATION (name,domain,logo) VALUES ('ACME INC','acmeinc.com','http://acmeinc.com/logo.gif');
INSERT INTO georeachdb.ROLE (name) VALUES ('Administrator');
INSERT INTO georeachdb.ROLE (name) VALUES ('User');
INSERT INTO georeachdb.USER (org_id,firstname,lastname,gender,email,phone1,phone2,login,password,role_id) VALUES (1,'Mark','Antony','M','mantony@acmeinc.com','9205300006','','mantony@acmeinc.com','pass123',1);
select * from georeachdb.organization;
select * from georeachdb.role;
select * from georeachdb.user;
select * from georeachdb.segment;
insert into georeachdb.segment(name, geography, user_id, org_id) values ('PackerFans','in:city:Green Bay|in:city:Appleton',1,1);
insert into georeachdb.experience (name, type, status, org_id, user_id, create_time) values ('Team Affinity Image','Image','on',1,1,now()) ;
insert into georeachdb.image (experience_id, segment_id, url, create_time) values (1,10,'https://www.associatedbank.com/content/image/brewers-cc-slide-btn',now());
insert into georeachdb.image (experience_id, segment_id, url, create_time) values (1,11,'https://www.associatedbank.com/content/image/wild-cc-slide-btn',now());
-----------------------------------------------------------------------------------------------
GIT:

Signin to GitHub.com with your onwardpath email
Optional: Install GitBash (Git-2.21.0-64-bit from https://git-scm.com/download/win)

Start GitBash
$ git config --global user.name "pandyan"
$ git config --global user.email "pandyans@onwardpath.com"

From Eclipse, specify your GIT Local Repository as follows:
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

TESTING:
https://www.geoscreenshot.com/
http://lab01.onwardpath.com/geosmart/

OTHER PRODUCTS:
https://optimize.google.com/optimize/home/#/accounts

UI FRAMEWORK:
REACT: 
http://react-material.fusetheme.com/

BOOTSTRAP: 
https://keenthemes.com/keen/preview/demo5/rtl/index.html
https://themes.getbootstrap.com/preview/?theme_id=6063&show_new=

DMA (DESIGNATED MARKET AREAS)
https://www.nielsen.com/intl-campaigns/us/dma-maps.html
http://bl.ocks.org/simzou/6459889

FEATURES WISHLIST
1. Since we are not storing the URL for the experience, we need a way to list all pages where the experience is being used (Embed Code is present)
2. New Feature: Search for JavaScript code in web-pages. Client is unable to search and locate a code they placed earlier.
3. Feature: Roll-back Experiences to an earlier version
4. Archive/Delete/Purge features
5. Switch CSS based on visitor location: https://www.w3schools.com/css/css_intro.asp
6. Feature to support ABM. Detect Organization IP Address and allow segments for accounts - Ex: Schneider
6. Support Demography(age, gender etc..) in Segments. Google Analytics API can be used to get demography information real-time
	https://segment.com/partners/developer-center/
	https://segment.com/catalog/
	Facebook Graph API 
	https://useproof.com/experiences?ref=segment
	https://www.mutinyhq.com/

DEMO ENVIROMENT:
Web Application --  Configure Experience (lab01.onwardpath.com/georeach)
Web Services -- Called from clients Website (lab01.onwardpath.com/geoservice)
Client Website  -- Webpage with geo enabled content (www.onwardpath.com/geodemo)
	
JavaScript file with error
WebContent/assets/js/demo1/pages/crud/datatables/advanced/footer-callback.js
WebContent/assets/js/demo1/pages/crud/datatables/advanced/row-grouping.js
	



Read-me file for GeoReach project

DEVELOPER SETUP:

Install JDK 1.8 to C:\Java\ (jdk-8u211-windows-x64)
Install Eclipse (eclipse-inst-win64)
Install Tomcat (apache-tomcat-8.0.9-windows-x64)
Install MySQL Server (mysql-installer-web-community-8.0.16.0)
	TCP/IP Port: 3306
	X Protocol Port: 33060
	MySQL Root Password: onwardAdmin1
	User Name: onwardDev
	Password: onwardDev1
Download MySQL Connector/J Platform Independent Version(https://dev.mysql.com/downloads/connector/j/)
Install Git (Git-2.21.0-64-bit from https://git-scm.com/download/win)

DATABASE SCHEMA:

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
;

ALTER TABLE `georeachdb`.`user` 
ADD CONSTRAINT `org_id_fk`
  FOREIGN KEY (`org_id`)
  REFERENCES `hello_world`.`organization` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE TABLE `georeachdb`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `georeachdb`.`user` 
ADD INDEX `role_id` (`role_id` ASC) VISIBLE;
;

ALTER TABLE `georeachdb`.`user` 
ADD CONSTRAINT `role_id_fk`
  FOREIGN KEY (`role_id`)
  REFERENCES `hello_world`.`role` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

POPULATE TEST DATA:

INSERT INTO ORGANIZATION (name,domain,logo) VALUES ('ACME INC','acmeinc.com','http://acmeinc.com/logo.gif');
INSERT INTO ROLE (name) VALUES ('Administrator');
INSERT INTO ROLE (name) VALUES ('User');
INSERT INTO USER (org_id,firstname,lastname,gender,email,phone1,phone2,login,password,role_id) VALUES (1,'Mark','Antony','M','mark.antony@acmeinc.com','9205300006','','mantony','pass123',1);

select * from organization;
select * from role;
select * from user;

CREATE TABLE `georeachdb`.`segment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `geography` TEXT(5000) NULL,
  `user_id` INT NOT NULL,
  `org_id` INT NOT NULL,
  PRIMARY KEY (`id`));
  
 


GIT:

Signin to GitHub.com with your onwardpath email
Install Git (Git-2.21.0-64-bit from https://git-scm.com/download/win)

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




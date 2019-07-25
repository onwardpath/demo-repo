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

HTML5 EDITORS:
https://rawgit.com/alohaeditor/Aloha-Editor/hotfix/src/demo/boilerplate/
https://www.froala.com/wysiwyg-editor/pricing

TESTING:
https://www.geoscreenshot.com/
https://crossbrowsertesting.com/
http://lab01.onwardpath.com/geosmart/

OTHER PRODUCTS:
https://optimize.google.com/optimize/home/#/accounts
https://www.gartner.com/en/documents/3883805

UI FRAMEWORK:
REACT: 
http://react-material.fusetheme.com/

BOOTSTRAP: 
https://keenthemes.com/keen/preview/demo5/rtl/index.html
https://themes.getbootstrap.com/preview/?theme_id=6063&show_new=

DMA (DESIGNATED MARKET AREAS)
https://www.nielsen.com/intl-campaigns/us/dma-maps.html
http://bl.ocks.org/simzou/6459889

ANALYTICS:
Cross Device Tracking:
https://www.optimizesmart.com/understanding-universal-analytics-measurement-protocol/#a1
A Google Analytics Data Model:
https://www.vertabelo.com/blog/technical-articles/website-analytics-a-google-analytics-data-model
https://my.vertabelo.com/model/P61M7h7pa4y5n9UJxlcTuOEzbelutkdi
Build Your Own Web Analytics Platform in 25 Minutes:
https://www.chaoming.li/blog/build-your-own-web-analytics-platform-in-25-minutes
Matamo:
https://developer.matomo.org/guides/getting-started-part-1
https://developer.matomo.org/integration

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
7. Geo Capability in E-Mails
8. Create segments based on Visitor Behaviour. 
	Example: If user has visited "www.acmeinc.com/greenbay-packers.html" they can be segmented as "PackerFans".
	Example: New Visitor, Repeat Visitor
	

PREVIEW FEATURE:
Node JS:
https://github.com/john-doherty/node-iframe-replacement/blob/master/README.MD
Java: 
https://jsoup.org/ -Java library for working with real-world HTML. It provides a very convenient API for extracting and manipulating data, using the best of DOM, CSS, and jquery-like methods.
http://www.devx.com/tips/Tip/41768 

DEMO ENVIROMENT:
Web Application --  Configure Experience (lab01.onwardpath.com/georeach)
Web Services -- Called from clients Website (lab01.onwardpath.com/geoservice)
Client Website  -- Webpage with geo enabled content (www.onwardpath.com/geodemo)
	
JavaScript file with error
WebContent/assets/js/demo1/pages/crud/datatables/advanced/footer-callback.js
WebContent/assets/js/demo1/pages/crud/datatables/advanced/row-grouping.js

SEGMENT FORMAT:
loc{include:city:San Jose-CA-USA|include:city:Santa Clara-CA-USA|include:city:Fremont-CA-USA}
beh{include:visit:equals:10|include:session:equals:60}
int{include:visit:equals:1:onwardpath.com/packers-info}
ref{source:match:google.com}

BUG LIST:
VM1649 vendors.bundle.js:9837 POST http://localhost:8080/GeoReach/inc/api/datatables/demos/default.php 404

FINANCIAL WEBSITES:
https://thefinancialbrand.com/45952/banking-website-personalization/


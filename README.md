PennApps Portal
=============

General Overview of Code
------------------------
* All collections are in `collections/`
* Server only code such as publications goes in `server/`
* Client only code goes in `client/`
  * External library code goes in `client/js/`
  * Client code that doesn't relate to a specific view like the router goes in `client/helpers/`
  * CSS goes in `client/css/`
  * Template code goes directly in `client`
* Images and other static files are in `public/`

Setup
-----
* Install Meteor `curl https://install.meteor.com | sh`
* Install [NPM] (http://nodejs.org/download/)
* Install meteorite `npm install -g meteorite`

You also may have to install gcc and g++

Running the app
---------------
* Run `mrt` in the root app directory
* The app can be viewed in a browser at [localhost:3000] (http://localhost:3000)

Documentation
--------------
* Meteor (http://docs.meteor.com)
* Underscore (http://underscorejs.org)
* Bootstrap (http://getbootstrap.com/2.3.2/)

nginx-homebrew-support
======================

[nginx](http://wiki.nginx.org) is great and [homebrew](http://mxcl.github.com/homebrew/) is great.

However nginx-homebrew's default OS X support files assume you want a user-specific setup, as explained in *Caveats* after installation:

	==> Caveats
	In the interest of allowing you to run `nginx` without `sudo`, the default
	port is set to localhost:8080.

	If you want to host pages on your local machine to the public, you should
	change that to localhost:80, and run `sudo nginx`. You'll need to turn off
	any other web servers running port 80, of course.

	You can start nginx automatically on login running as your user with:
	  mkdir -p ~/Library/LaunchAgents
	  cp /usr/local/Cellar/nginx/1.2.6/homebrew.mxcl.nginx.plist ~/Library/LaunchAgents/
	  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

	Though note that if running as your user, the launch agent will fail if you
	try to use a port below 1024 (such as http's default of 80.)

	To have launchd start nginx at login:
		ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
	Then to load nginx now:
		launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

I always want to run nginx as a machine-wide service, listening to port 80 and not tied to a specific account. The support files in this repo supplement nginx-homebrew to achieve those goals.

Installation
------------

Make sure you have nginx already installed: execute `brew update && brew install nginx` if you haven't.

Double-click `install.command`. It will:

* Creates & populates `/Library/Nginx` if it doesn't already exist.
* Copies `org.nginx.plist` into `/Library/LaunchAgents`.
	* Invokes `launchctl` to immediately register the nginx LaunchAgent and start nginx.


Where Things Reside
-------------------

Thing                    |  Location
-----                    |  --------
Nginx Configuration      |  `/Library/Nginx/Configuration/`
Website Content (HTML)   |  `/Library/Nginx/Sites/default-site/html/`
Site-Specific Log Files  |  `/Library/Nginx/Sites/default-site/logs/`
Nginx PID file           |  `/usr/local/var/run/nginx.pid`
Newsyslog Configuration  |  `/etc/newsyslog.d/nginx.conf`
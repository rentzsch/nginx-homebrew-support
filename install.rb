#!/usr/bin/ruby

if !File.exist?('/Library/Nginx')
  puts '*** Creating /Library/Nginx'
  `sudo mkdir /Library/Nginx`
  `sudo chgrp admin /Library/Nginx`
  `sudo chmod g+w /Library/Nginx`
  
  puts '*** Populating /Library/Nginx'
  require 'fileutils'
  FileUtils.cp_r(Dir['Library/Nginx/*'],'/Library/Nginx')
else
  puts '*** /Library/Nginx already exists'
end

if !File.exist?('/Library/LaunchAgents/org.nginx.plist')
  puts '*** Installing Nginx LaunchAgent'
  `sudo cp Library/LaunchAgents/org.nginx.plist /Library/LaunchAgents/org.nginx.plist`
  `sudo chown root /Library/LaunchAgents/org.nginx.plist`
  `sudo chmod go-rwx /Library/LaunchAgents/org.nginx.plist`
  `sudo launchctl load /Library/LaunchAgents/org.nginx.plist`
end

puts '*** Nginx should now be installed and running, acessible at http://localhost'
puts '*** If things aren\'t working, check out /Library/Nginx/stderr.log and /Library/Nginx/error.log for clues.'

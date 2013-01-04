#!/usr/bin/ruby

if !File.exist?('/Library/Nginx')
  puts '*** Creating /Library/Nginx'
  `sudo mkdir /Library/Nginx`
  `sudo chgrp admin /Library/Nginx`
  `sudo chmod g+w /Library/Nginx`
  
  puts '*** Populating /Library/Nginx'
  require 'fileutils'
  FileUtils.cp_r(Dir['Library/Nginx/*'],'/Library/Nginx')
  
  #FileUtils.cp_r(Dir['/usr/local/etc/nginx/*'],'/Library/Nginx/Configuration')
  require 'pathname'
  nginxBinPath = Pathname.new('/usr/local/sbin/nginx').realpath
  nginxDirPath = nginxBinPath.parent.parent.to_s
  
  #`touch /usr/local/var/run/nginx.pid` # in case nginx hasn't been ever run yet
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

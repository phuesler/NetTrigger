require "rubygems"
require "rake"

require "choctop"

require 'deploy/ftp_sync'
require 'highline/import'

module Appcast
  def upload_appcast
    passwd = ask("Password for ftp server please: ") { |q| q.echo = "x"}
    ftp = FtpSync.new('ftp.huesler-informatik.ch', 'nettrigger@huesler-informatik.ch', passwd.chomp)
    ftp.sync(build_path, '/downloads')
  end
  
  def make_dmg_symlink
    FileUtils.chdir(build_path) do
      `rm '#{versionless_pkg_name}'` if File.exists?(versionless_pkg_name)
      `ln -s '#{pkg_name}' '#{versionless_pkg_name}'`
    end
  end
end


ChocTop.new do |s|
  # Remote upload target (set host if not same as Info.plist['SUFeedURL'])
  # s.host     = 'nettrigger.com'
  # s.remote_dir = '/var/www/applications/nettrigger'
  s.build_target = 'Release'

  # Custom DMG
  # s.background_file = "background.jpg"
  # s.app_icon_position = [100, 90]
  # s.applications_icon_position =  [400, 90]
  # s.volume_icon = "dmg.icns"
  # s.applications_icon = "appicon.icns" # or "appicon.png"
end

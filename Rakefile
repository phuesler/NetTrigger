require "rubygems"
require "rake"

require "choctop"

require 'deploy/ftp_sync'
require 'highline/import'

class ChocTop
  def user
    @user ||= ask("User for server please: ")
  end
end
module Appcast  
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
  s.build_target = 'Release'
  s.remote_dir = '/home/mosphere/www/applications.huesler-informatik.ch/downloads/NetTrigger'
  # Custom DMG
  s.background_file = "dmg_background.png"
  # s.app_icon_position = [100, 90]
  # s.applications_icon_position =  [400, 90]
  # s.volume_icon = "dmg.icns"
  # s.applications_icon = "appicon.icns" # or "appicon.png"
end

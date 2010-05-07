class NetTriggerDelegate
  attr_accessor :preferenceController, :statusBarMenu
    
  def applicationDidFinishLaunching(notification)
    @monitor = WifiMonitor.alloc.initWithDelegate(self)
    activateStatusMenu
  end
  
  def preferenceController
    unless @preferenceController
      @preferenceController = PreferenceController.alloc.init
    end
    @preferenceController
  end
  
  def showPreferencePanel(sender)
    NSApp.activateIgnoringOtherApps(true)
    preferenceController.showWindow(self)
  end
  
  def wifiChangedTo(ssid)
   rule = preferenceController.ruleForSSID(ssid)
   if rule
     NSTask.launchedTaskWithLaunchPath("/usr/sbin/scselect",
                                      arguments:[rule['location']])
   end
  end

  def activateStatusMenu
    statusBarItem = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength)
    statusBarItem.setToolTip("NetTrigger")
    statusBarItem.setHighlightMode(true)
    statusBarItem.setEnabled(true)
    
    statusImage = NSImage.alloc.initWithContentsOfFile(
                                  NSBundle.mainBundle.pathForResource("network", ofType: "png")
                                  )
    statusBarItem.setImage(statusImage)
    statusBarItem.setAlternateImage(statusImage)
    statusBarItem.setMenu(statusBarMenu)
  end
  
  def applicationShouldTerminate(sender)
    preferenceController.saveSettings
    return NSTerminateNow
  end
end

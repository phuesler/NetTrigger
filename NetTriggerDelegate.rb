class NetTriggerDelegate
  attr_accessor :preferenceController, :statusBarMenu
    
  def applicationDidFinishLaunching(notification)
    @monitor = WifiMonitor.alloc.initWithDelegate(self)
    NSNotificationCenter.defaultCenter.addObserver(self,
                                                  selector: "checkTaskStatus:".to_sym,
                                                  name: NSTaskDidTerminateNotification,
                                                  object: nil)
    activateStatusMenu
  end
  
  def preferenceController
    @preferenceController ||= PreferenceController.alloc.init
  end
  
  def showPreferencePanel(sender)
    preferenceController.showWindow(self)
  end
  
  def checkTaskStatus(notification)
     if (notification.object.terminationStatus == 0)
         NSLog("Task succeeded.")
     else
         NSLog("Task failed.")
    end
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
end

class NetTriggerDelegate
  attr_accessor :preferenceController
    
  def applicationDidFinishLaunching(notification)
    @monitor = WifiMonitor.alloc.initWithDelegate(self)
    NSNotificationCenter.defaultCenter.addObserver(self,
                                                  selector: "checkTaskStatus:".to_sym,
                                                  name: NSTaskDidTerminateNotification,
                                                  object: nil)
    return self;
  end
  
  def showPreferencePanel(sender)
    if(!preferenceController)
      preferenceController = PreferenceController.alloc.init
    end
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
   if NSUserDefaults.standardUserDefaults['ssid'] == ssid
     NSTask.launchedTaskWithLaunchPath("/usr/sbin/scselect",arguments:[NSUserDefaults.standardUserDefaults['location']])
   end
   NSLog("hello wifi changed to #{ssid}")
  end
end

class NetTriggerDelegate
  def applicationDidFinishLaunching(notification)
    @monitor = WifiMonitor.alloc.initWithDelegate(self)
    NSNotificationCenter.defaultCenter.addObserver(self,
                                                  selector: "checkTaskStatus:".to_sym,
                                                  name: NSTaskDidTerminateNotification,
                                                  object: nil)
    return self;
  end
  
  def checkTaskStatus(notification)
     if (notification.object.terminationStatus == 0)
         NSLog("Task succeeded.")
     else
         NSLog("Task failed.")
    end
  end
  
  def wifiChangedTo(ssid)
   NSTask.launchedTaskWithLaunchPath("/usr/sbin/scselect",arguments:["Automatic"])
   NSLog("hello wifi changed to #{ssid}")
  end
end

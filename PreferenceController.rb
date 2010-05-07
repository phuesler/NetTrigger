class PreferenceController < NSWindowController
  attr_accessor :rules
  
  def saveSettings
    NSUserDefaults.standardUserDefaults['rules'] = rules
  end
  
  def ruleForSSID(ssid)
    rules.select{|rule| rule['ssid'] == ssid}.first
  end
  
  def init
    if(!super.initWithWindowNibName("Preferences"))
      return nil
    else
      @rules ||= NSUserDefaults.standardUserDefaults['rules'] || []
      return self
    end
  end
end

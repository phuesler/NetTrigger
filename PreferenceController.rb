class PreferenceController < NSWindowController
  attr_accessor :rules
  
  def rules
    @rules ||= NSUserDefaults.standardUserDefaults['rules'] || []
  end
  
  def store(sender)
    NSUserDefaults.standardUserDefaults['rules'] = rules
  end
  
  def ruleForSSID(ssid)
    rules.select{|rule| rule['ssid'] == ssid}.first
  end
  
  def init
    if(!super.initWithWindowNibName("Preferences"))
      return nil
    else
      return self
    end
  end
end

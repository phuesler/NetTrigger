#import "WifiMonitor.h"

NSString* const WifiInterfaceName = @"State:/Network/Interface/en1/AirPort";

void updateCallBack(SCDynamicStoreRef store, CFArrayRef changedKeys, void *info) {
	[(WifiMonitor *)info wifiChanged];
}


@implementation WifiMonitor

- (id) initWithDelegate:(NSObject *)object {
    if ((self = [super init])) {
       delegate = object;
    [self setupWifiNotifications];
	}
	return self;
}

- (void) fetchCurrentSSID {
	NSDictionary *values = (NSDictionary *)SCDynamicStoreCopyValue(store, (CFStringRef) WifiInterfaceName);
	currentSSID = [values objectForKey:@"SSID_STR"];
	[currentSSID retain];
	[values release];
}

- (void) wifiChanged {
	NSString * oldSSID = [currentSSID copy];
	[self fetchCurrentSSID];
	if(![oldSSID isEqualToString:currentSSID])
	{
     [delegate wifiChangedTo: currentSSID];
	}
	[oldSSID release];
}

- (void) setupWifiNotifications {
	// get the dynamic store
	SCDynamicStoreContext context = {0, self, NULL, NULL, NULL};
	store = SCDynamicStoreCreate(NULL, (CFStringRef)@"HallenprojektStatusAppDelegate", updateCallBack, &context);
	
	NSArray *array = [NSArray arrayWithObject:WifiInterfaceName];
	if (!SCDynamicStoreSetNotificationKeys(store, (CFArrayRef)array, NULL)) {
		NSLog(@"failed to set notification keys");
		return;
	}
	[self fetchCurrentSSID];
	
	CFRunLoopSourceRef runLoopSource = SCDynamicStoreCreateRunLoopSource(NULL, store, 0);
	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
	CFRelease(runLoopSource);
	
}

@end

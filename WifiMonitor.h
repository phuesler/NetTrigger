#import <Cocoa/Cocoa.h>
#import <SystemConfiguration/SCDynamicStore.h>

extern NSString* const WifiInterfaceName;

@interface WifiMonitor : NSObject {
	SCDynamicStoreRef store;
	NSString *currentSSID;
   NSObject *delegate;
}

- (id)initWithDelegate:(NSObject *)object;
- (void) setupWifiNotifications;
- (void) wifiChanged;
@end

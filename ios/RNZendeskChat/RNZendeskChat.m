#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNZendeskChat, NSObject<RCTBridgeModule>)

  RCT_EXTERN_METHOD(setVisitorInfo: (NSDictionary *)options )
  RCT_EXTERN_METHOD(startChat: (NSDictionary *)options )
  RCT_EXTERN_METHOD(init: (NSDictionary *)zenDeskKey )

@end

@implementation RNZendeskChat
@end

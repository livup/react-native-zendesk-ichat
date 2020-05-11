#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNZendeskChat, NSObject)

  RCT_EXTERN_METHOD(setVisitorInfo: (NSDictionary *)options )
  RCT_EXTERN_METHOD(startChat: (NSDictionary *)options )
  RCT_EXTERN_METHOD(init: (NSDictionary *)zenDeskKey )

@end

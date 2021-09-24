// Objective C Bridge to SDKRunner Swift class

#import "React/RCTBRidgeModule.h"

// Adds the SDKRunner class as a callable module to React Native
@interface RCT_EXTERN_MODULE(SDKRunner, NSObject)

// Registers the scan method within the SDKRunner Swift class so that it is recognized by React Native
RCT_EXTERN_METHOD(
                  scan:(RCTResponseSenderBlock)callback
                  )

@end

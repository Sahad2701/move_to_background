#import "MoveToBackgroundPlugin.h"

@implementation MoveToBackgroundPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
                                   methodChannelWithName:@"move_to_background"
                                   binaryMessenger:[registrar messenger]];
  MoveToBackgroundPlugin* instance = [[MoveToBackgroundPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"moveTaskToBack" isEqualToString:call.method]) {
    UIApplication *app = [UIApplication sharedApplication];

    if ([app respondsToSelector:@selector(suspend)]) {
      #pragma clang diagnostic push
      #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      [app performSelector:@selector(suspend)];
      #pragma clang diagnostic pop

      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"UNAVAILABLE"
                                 message:@"Cannot move app to background."
                                 details:nil]);
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end

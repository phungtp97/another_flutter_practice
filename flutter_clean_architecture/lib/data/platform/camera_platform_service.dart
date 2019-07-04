import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/data/platform/platform_service.dart';

class CameraPlatformService extends PlatformService{
  final String channelName;

  CameraPlatformService(this.channelName) : super(channelName);

  void handleCallback(Function(MethodCall) callback){
    getPlatform().setMethodCallHandler((MethodCall call){
      callback(call);
    });
  }

}
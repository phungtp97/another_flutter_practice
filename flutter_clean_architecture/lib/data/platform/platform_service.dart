import 'package:flutter/services.dart';

abstract class PlatformService{
  static MethodChannel platform;

  final String channelName;
  PlatformService(this.channelName){
    platform = MethodChannel(channelName);
  }

  String getChannelName(){
    return channelName;
  }

  MethodChannel getPlatform(){
    return platform;
  }
}
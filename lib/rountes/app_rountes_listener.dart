import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutingListener {
  // 路由监听
  static Function(Routing?)? routingListner = (routing) {
    debugPrint("上级页面 > > > :${routing!.previous}");
    debugPrint("当前页面 > > > :${routing.current}");
    debugPrint("路由传参 > > > :${routing.args}");
  };
}

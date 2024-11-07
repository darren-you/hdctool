import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hdctool/pages/base_shell_interface.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class MainNavViewModel extends GetxController
    with TrayListener, BaseHdcShellInterface {
  var currentTab = (-1).obs;
  final deviceIPEditController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    logger.d('onInit > MainNavViewModel');
    trayManager.addListener(this);
    await trayManager.setIcon(
      Platform.isWindows
          ? 'images/tray_icon_original.ico'
          : 'images/tray_icon_original.png',
    );
  }

  @override
  void onClose() {
    super.onClose();
    trayManager.removeListener(this);
  }

  // 顶部状态栏图标
  @override
  void onTrayIconMouseDown() {
    windowManager.show();
  }

  // hdc版本
  Future<void> getHdcVersion() async {
    await execHdc(['--version']);
  }

  // 查询连接设备
  Future<ProcessResult?> getConnectedDevices() async {
    return await execHdc(['list targets']);
  }

  // 无线连接
  Future<ProcessResult?> connectDeviceT() async {
    const command = 'tconn';
    final target = deviceIPEditController.text;
    return await execHdc([command, target]);
  }
}

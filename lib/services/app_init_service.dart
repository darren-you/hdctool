import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:window_manager/window_manager.dart';

final Logger logger = Logger();

class AppInitService {
  static Future<void> init() async {
    debugPrint('< < <   全局初始化 start...   > > >');
    // 初始化 WidgetsFlutterBinding
    WidgetsFlutterBinding.ensureInitialized();

    // window_manager
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1045, 670),
      minimumSize: Size(1045, 670),
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // await windowManager.show();
      // await windowManager.focus();
    });

    // macos_window_utils
    await WindowManipulator.initialize();
    await WindowManipulator.enableShadow();
    await WindowManipulator.hideTitle();
    await WindowManipulator.makeTitlebarTransparent();
    await WindowManipulator.enableFullSizeContentView();
    await WindowManipulator.setMaterial(NSVisualEffectViewMaterial.sidebar);

    // 初始化本地存储服务
    final getStorage = await GetStorage.init();
    getStorage
        ? debugPrint("初始化全局单例 GetStorage 完成✅")
        : debugPrint("初始化全局单例 GetStorage 失败❌");

    // 初始化本地时间服务
    initializeDateFormatting(); // 初始化日期格式化信息
    debugPrint("初始化日期格式化信息 完成✅");

    debugPrint('< < <   全局初始化 end...   > > >');
  }
}

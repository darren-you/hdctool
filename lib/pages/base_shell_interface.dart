import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;

import 'dart:io';

import 'package:process_run/shell_run.dart';

import '../components/view/we_chat_loading.dart';

class HdcShellUtils {
  static final HdcShellUtils _instance = HdcShellUtils._internal();
  factory HdcShellUtils() => _instance;

  late String hdcPath;
  final Shell shell = Shell(
    workingDirectory:
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'],
    environment: Platform.environment,
    throwOnError: false,
    stderrEncoding: const Utf8Codec(),
    stdoutEncoding: const Utf8Codec(),
  );

  HdcShellUtils._internal() {
    final resolvedExecutablePath = Platform.resolvedExecutable;
    final rootPath = p.dirname(p.dirname(resolvedExecutablePath));
    hdcPath = p.join(rootPath, "Frameworks", "App.framework", "Resources",
        "flutter_assets", "platform-tools", "MacOS", "hdc");
  }
}

abstract mixin class BaseHdcShellInterface {
  final Logger logger = Logger();
  final Shell _shell = HdcShellUtils().shell;
  final String _hdcPath = HdcShellUtils().hdcPath;

  Future<ProcessResult?> _exec(
    String executable,
    List<String> arguments, {
    void Function(Process process)? onProcess,
  }) async {
    // 此处根据界面上是否存在Dialog，决定是否再显示Dialog
    if (!SmartDialog.checkExist()) {
      await SmartDialog.show(
        backType: SmartBackType.ignore,
        clickMaskDismiss: false,
        maskColor: Colors.grey.withAlpha(400),
        useAnimation: true,
        displayTime: const Duration(seconds: 1),
        builder: (BuildContext context) {
          return const CircleLoadingIndicator();
        },
      );
    }

    try {
      final result = await _shell.runExecutableArguments(executable, arguments);
      SmartDialog.dismiss();
      if (result.exitCode == 0) {
        await SmartDialog.showNotify(
            msg: 'msg:${result.stdout}',
            notifyType: NotifyType.success,
            displayTime: const Duration(seconds: 2));
        logger.d('命令执行成功');
        logger.d('标准输出: ${result.stdout}');
        return result;
      } else {
        await SmartDialog.showNotify(
            msg: 'code:${result.exitCode}, msg:${result.stderr}',
            notifyType: NotifyType.error,
            displayTime: const Duration(seconds: 2));
        logger.d('命令执行失败');
        logger.d('退出代码: ${result.exitCode}');
        logger.d('错误输出: ${result.stderr}');
      }
      return result;
    } catch (e) {
      logger.d("exec exception: $e");
      SmartDialog.dismiss();
      SmartDialog.showNotify(msg: e.toString(), notifyType: NotifyType.failure);
      return null;
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<ProcessResult?> execHdc(List<String> arguments,
      {void Function(Process process)? onProcess}) async {
    if (_hdcPath.isEmpty) {
      SmartDialog.showNotify(msg: "未找到hdc", notifyType: NotifyType.warning);
      return null;
    }
    return await _exec(_hdcPath, arguments, onProcess: onProcess);
  }
}

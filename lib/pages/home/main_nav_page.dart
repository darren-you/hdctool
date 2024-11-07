import 'package:flutter_svg/svg.dart';
import 'package:hdctool/components/input/custom_edit.dart';
import 'package:hdctool/utils/assert_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hdctool/pages/home/main_nav_vm.dart';
import 'package:hdctool/utils/bar_util.dart';

import '../../components/container/custom_icon_button.dart';

class MainNavPage extends GetView<MainNavViewModel> {
  const MainNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          // 左侧菜单栏
          SizedBox(
            width: 160,
            height: context.height,
            child: Column(
              children: [
                // TitleBar 高度
                SizedBox(width: 210, height: BarUtil.height + 38),
                // 无线连接
                Container(
                  width: 138,
                  height: 28,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFEAEAEA),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      CustomEdit(
                        width: 97.5,
                        height: 28,
                        editController: controller.deviceIPEditController,
                        showSuffixIcon: false,
                        enableShowBorder: false,
                        borderRadius: BorderRadius.circular(0),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 0.5,
                        height: 16,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 12,
                        height: 24,
                        child: CustomIconButton(
                          AssertUtil.iconGo,
                          alignment: Alignment.centerRight,
                          backgroundWidth: 24,
                          backgroundHeight: 24,
                          //background: Colors.green,
                          onTap: () {
                            controller.connectDeviceT();
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),

                const SizedBox(width: 210, height: 16),
                // 功能Item
                GestureDetector(
                  onTap: () {
                    controller.currentTab.value = 0;
                  },
                  child: Obx(
                    () => Container(
                      width: 138,
                      height: 28,
                      padding: const EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: controller.currentTab.value == 0
                            ? const Color(0xFFEAEAEA)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14,
                            height: 20,
                            // 0070f5
                            //child: SvgPicture.asset(AssertUtil.svgMobile),
                            child: Image.asset(AssertUtil.mate60pro),
                          ),
                          const SizedBox(width: 8),
                          const Text('Mate 60 Pro'),
                          const Spacer(),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF57BE6A),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.currentTab.value = 1;
                  },
                  child: Obx(
                    () => Container(
                      width: 138,
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: controller.currentTab.value == 1
                            ? const Color(0xFFEAEAEA)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14,
                            height: 28,
                            // 0070f5
                            child: SvgPicture.asset(AssertUtil.svgHdc),
                          ),
                          const SizedBox(width: 8),
                          const Text('hdc'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 功能区域
          Expanded(
            child: Stack(
              children: [
                // 主体区域
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 260,
                        //color: Colors.blue,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 60,
                        ),
                        child: Image.asset(AssertUtil.mate60pro),
                      ),
                      Container(
                        //color: Colors.amber,
                        margin: const EdgeInsets.symmetric(vertical: 80),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mate 60 Pro",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text("电量: 100%"),
                            SizedBox(height: 4),
                            Text("API: 12"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    // 导航栏
                    Container(
                      width: context.width,
                      height: 52,
                      color: const Color(0xFFFDFDFD),
                      child: const Row(
                        children: [
                          SizedBox(width: 24),
                          // 导航栏标题
                          Text(
                            "Mate 60 Pro",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    // 分割线
                    Container(
                      width: context.width,
                      height: 1,
                      color: const Color(0xFFCACBCB).withAlpha(100),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

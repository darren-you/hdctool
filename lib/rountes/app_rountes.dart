import 'package:get/get.dart';
import 'package:hdctool/pages/home/main_nav_page.dart';

import '../pages/home/main_nav_vm.dart';
import '../utils/page_path_util.dart';

class AppRountes {
  // 别名路由配置
  static List<GetPage<dynamic>>? appRoutes = [
    // APP进入主页，导航栏界面
    // APP进入主页，导航栏界面
    GetPage(
      name: PagePathUtil.bottomNavPage,
      page: () => const MainNavPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => MainNavViewModel());
        },
      ),
    ),
  ];
}

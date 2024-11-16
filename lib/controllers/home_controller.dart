import 'package:get/get.dart';

class HomeController extends GetxController {
    var selectedIndex = Rx<int?>(null);
     var tabIndex = 1.obs; // Initial tab index set to 1

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

    var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

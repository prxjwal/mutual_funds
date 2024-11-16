import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class SecondController extends GetxController {
 var selectedPeriod = "3 years".obs;

  void updatePeriod(String period) {
    selectedPeriod.value = period;
  }
  final selected = '1Y'.obs;

    // Observable for selected data point
  var selectedData = "₹432".obs;
  var selectedDate = "18 Aug 2024".obs;

  // Method to update data on touch
  void updateSelectedData(String date, String value) {
    selectedDate.value = date;
    selectedData.value = value;
  }


  var selectedIndex = 2.obs; // Default to 1Y (index 2)

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  final prices = <FlSpot>[
    FlSpot(0, 110),
    FlSpot(1, 140),
    FlSpot(2, 120),
    FlSpot(3, 140),
    FlSpot(4, 250),
    FlSpot(5, 180),
    FlSpot(6, 190),
    FlSpot(7, 180),
    FlSpot(8, 240),
    FlSpot(9, 150),
    FlSpot(10, 180),
    FlSpot(11, 280),
    FlSpot(12, 350),
    FlSpot(13, 450),
    FlSpot(14, 420),
    FlSpot(15, 380),
    FlSpot(16, 320),
    FlSpot(17, 280),
    FlSpot(18, 320),
  ].obs;
}

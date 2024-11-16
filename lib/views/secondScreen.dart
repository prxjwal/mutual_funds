import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/second_controller.dart';
import 'qr_code_scanner_page.dart';

class SecondScreen extends StatelessWidget {
  
  final SecondController controller = Get.put(SecondController());

  final List<String> tabs = ['3M', '6M', '1Y', '3Y', 'MAX', 'SIP'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight, // Aligns the icon to the left
          child: GestureDetector(
            onTap: (){Get.back();},
            child: Image.asset(
              'lib/assets/icons/circle-arrow-left.png', // Replace with your image path
              width: 30,
              height: 30, // Adjust image to fit within the container
            ),
          ),
        ),
        title: Text(
          'Mutual Funds',
          style: TextStyle(
            fontFamily: 'MyCustomFont', // Use custom font for Mutual Funds
            fontSize: 27,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(QRCodeScannerPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'lib/assets/icons/bubble-chat-share.png', // Replace with your image path
                width: 30,
                height: 30, // Adjust image to fit within the container
              ),
            ),
          ),
        ],
      ),
      body: Expanded(
        child: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                width: Get.width,  // Full width of the screen
                height: 0,       // Set height to simulate a divider
                decoration: BoxDecoration(
                  color: Colors.grey,  // Color of the "divider"
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),  // Shadow color
                      spreadRadius: 2,                       // Shadow spread
                      blurRadius: 6,                         // Shadow blur
                      offset: Offset(0, 4),                  // Shadow position
                    ),
                  ],
                ),
              ),
              firstBox(),
              SecondBox(),
              thirdBox(),
              fourthBox(),


              Graph(controller: controller),





              Padding(
                padding: const EdgeInsets.only(top:8.0, ),
                child: SixithBox(tabs: tabs, controller: controller),
              ),



              lastBox()     











              


            ],
          ),
        ),
      ),
    );
  }
}

class lastBox extends StatelessWidget {
  const lastBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(top:26,left: 40,right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Key metrics',
              style: TextStyle(
                fontFamily: 'MyCustomFont', // Use custom font for Mutual Funds
                fontSize: 27,
              ),
            ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
    // Expense Ratio
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expense Ratio', 
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w300
            )),
        SizedBox(height: 3),
        Text('1.03 %', 
            style:GoogleFonts.notoSans(
              fontSize: 22,
              fontWeight: FontWeight.w700
            )),
      ],
    ),
    
    // Exit Load
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Exit Load', 
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w300)),
        SizedBox(height: 3),
        Text('1.00 %', 
            style: GoogleFonts.notoSans(
              fontSize: 22,
              fontWeight: FontWeight.w700
            )),
      ],
    ),
    
    // Sharpe Ratio
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sharpe Ratio', 
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w300
            )),
        SizedBox(height: 3),
        Text('3.20', 
            style: GoogleFonts.notoSans(
              fontSize: 22,
              fontWeight: FontWeight.w700
            )),
      ],
    ),
                ],
              ),
              Divider(height: 35),
            ],
          ),
        
    );
  }
}

class Graph extends StatelessWidget {
  const Graph({
    super.key,
    required this.controller,
  });

  final SecondController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, right: 16, left: 40, bottom: 25),
      height: 220,
      child: Stack(
        children: [
          LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 100,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
    return FlLine(
      color: Colors.grey[300],
      strokeWidth: 1,
    );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      interval: 100,
      reservedSize: 40,
    ),
                ),
                bottomTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: 18,
              minY: 0,
              maxY: 500,
              lineBarsData: [
                LineChartBarData(
    spots: controller.prices,
    isCurved: true,
    color: Colors.grey[600],
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
    ),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
    tooltipRoundedRadius: 8,
    tooltipPadding: EdgeInsets.all(8),
    tooltipMargin: 8,
    getTooltipItems: (touchedSpots) {
      // Customize tooltip content
      return touchedSpots.map((spot) {
        return LineTooltipItem(
          '${"18 Aug 2024"}\n₹ ${spot.y.toStringAsFixed(1)}',
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList();
    },
                ),
               
                touchSpotThreshold: 10, // Adjust sensitivity
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SixithBox extends StatelessWidget {
  const SixithBox({
    super.key,
    required this.tabs,
    required this.controller,
  });

  final List<String> tabs;
  final SecondController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: Obx(
          () => IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(tabs.length, (index) {
                bool isSelected = controller.selectedIndex.value == index;
                bool isFirst = index == 0;
                bool isLast = index == tabs.length - 1;
                
                return GestureDetector(
                  onTap: () => controller.selectTab(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple.shade50 : Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: isFirst ? Radius.circular(14) : Radius.zero,
                        right: isLast ? Radius.circular(14) : Radius.zero,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isSelected ? Colors.purple : Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple, width: 0),
                              borderRadius: BorderRadius.horizontal(
                                left: isFirst ? Radius.circular(14) : Radius.zero,
                                right: isLast ? Radius.circular(14) : Radius.zero,
                              ),
                            ),
                          ),
                        if (!isFirst && !isSelected)
                          Positioned(
                            left: 0,
                            top: 4,
                            bottom: 4,
                            child: Container(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class fourthBox extends StatelessWidget {
  const fourthBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for "Current NAV" label and date
          Row(
            children: [
              Text(
                "Current NAV ",
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "(As per 26th September 2024)",
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8), // Space between the text rows
          
          // NAV Value and Percentage
          Row(
            children: [
              Text(
                "493.80",
                style: GoogleFonts.notoSans(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Row(
                children: [
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                    size: 24,
                  ),
                  Text(
                    "2.34%",
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class thirdBox extends StatelessWidget {
  const thirdBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 10, left: 40, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row with CAGR and Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "CAGR" label and subtitle
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "CAGR ",
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "(Annualized return)",
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8), // Spacing between labels and value
                  // CAGR Value (Static)
                  Text(
                    "+23.98 %",
                    style: GoogleFonts.notoSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              // Dropdown for selecting period
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: SecondController().selectedPeriod.value,
                      underline: SizedBox(), // Remove default underline
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.purple,
                      ),
                      items: ["1 year", "3 years", "5 years", "10 years"]
                          .map((String period) {
                        return DropdownMenuItem<String>(
                          value: period,
                          child: Text(
                            period,
                            style: GoogleFonts.notoSans(color: Colors.purple),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          SecondController().updatePeriod(newValue);
                        }
                      },
                    ),
                  )),
            ],
          ),
          SizedBox(height: 16), // Space between row and divider
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class SecondBox extends StatelessWidget {
  const SecondBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // First container
          Container(
            padding: EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.grey), // Gray border color
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Text(
              'Growth',
              style: GoogleFonts.notoSans(fontSize: 16,
              fontWeight: FontWeight.w300),
              
            ),
          ),
          SizedBox(width: 10,),
          
          // Second container
          Container(
            padding: EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.grey), // Gray border color
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Text(
              'Equity',
              style: GoogleFonts.notoSans(fontSize: 16,
              fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(width: 10,),
          
          // Third container
          Container(
            padding: EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.grey), // Gray border color
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Text(
              'Value Fund',
              style: GoogleFonts.notoSans(fontSize: 16,
              fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
    );
  }
}

class firstBox extends StatelessWidget {
  const firstBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left small container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white, // Add a background color
              border: Border.all(
                color: Colors.grey.shade300, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(18), // Rounded corners
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18), // Ensure image respects border radius
              child: Image.asset(
                'lib/assets/icons/ICICI Bank logo 1.png', // Replace with your image path
                fit: BoxFit.contain, // Adjust image to fit within the container
              ),
            ),
          ),
          SizedBox(width: 16), // Space between left container and text section
          
          // Right text section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ICIC Pru Value Discovery Value', // Title text with custom font
                style: TextStyle(
                  fontFamily: 'MyCustomFont', // Use custom font for ICIC Pru
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'By ICICI group', // Subtitle text
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



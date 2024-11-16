import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../controllers/home_controller.dart';
import 'secondScreen.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => ConvexAppBar(
          
          height: 55,
          style: TabStyle.react,
          top: -20,
          backgroundColor: Colors.white,
          activeColor: Colors.purple[400],
          color: Colors.grey[700],
          items: [
            TabItem(icon: ImageIcon(AssetImage("lib/assets/icons/home.png"),size: 200
            ,), title: "Home",),
            TabItem(icon: ImageIcon(AssetImage("lib/assets/icons/investment.png")), title: "Mutual Funds"),
            TabItem(icon: ImageIcon( size: 30, AssetImage("lib/assets/icons/advisory.png")), title: "Advisory"),
            TabItem(icon: ImageIcon(AssetImage("lib/assets/icons/protofolio.png")), title: "Portfolio"),
          ],
          initialActiveIndex: controller.currentIndex.value,
          onTap: (int index) {
            controller.changeTab(index);
          },
        ),
      ),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Mutual Funds',
            style: TextStyle(
              fontFamily: 'MyCustomFont',
              fontSize: 27,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionButton('Filter', 'lib/assets/icons/filter.png'),
              _buildActionButton('Sort', 'lib/assets/icons/sorting.png'),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SearchBox(),
            const SizedBox(height: 10),
            SecodaryMenu(controller: controller),
            Expanded(
              child: Neumorphic(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: MutualFundCard(),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, String iconPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 75,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 3,
              left: 7,
              child: Text(
                text,
                style: GoogleFonts.notoSans(fontWeight: FontWeight.w300),
              ),
            ),
            Positioned(
              right: -8,
              top: 1,
              bottom: 1,
              child: Image.asset(iconPath, width: 50, height: 50),
            ),
          ],
        ),
      ),
    );
  }
}

class MutualFundCard extends StatelessWidget {
  const MutualFundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.to(SecondScreen());
        },
        child: Container(
          width: 380,
          height: 170,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1.0),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'lib/assets/icons/ICICI Bank logo 1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ICICI Pru Balanced Advantage Fund',
                          style: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quant group',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFundMetric('Expense Ratio', '1.01 %'),
                  _buildFundMetric('AUM', '3240 Cr.'),
                  _buildFundMetric('Avg. Returns (1 Yr)', '32.33 %',
                      textColor: Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFundMetric(String label, String value,
      {Color textColor = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }
}

class SecodaryMenu extends StatelessWidget {
  const SecodaryMenu({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'text': 'All'},
      {'icon': 'lib/assets/icons/equity.png', 'text': 'Equity'},
      {'icon': 'lib/assets/icons/debt.png', 'text': 'Debt'},
      {'icon': 'lib/assets/icons/hybrid.png', 'text': 'Hybrid'},
      {'icon': 'lib/assets/icons/commerce.png', 'text': 'Commerce'},
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(menuItems.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.selectedIndex.value = index;
              },
              child: Obx(() {
                bool isSelected = controller.selectedIndex.value == index;
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected ? Colors.purple : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (menuItems[index]['icon'] != null)
                        Image.asset(
                          menuItems[index]['icon'],
                          width: 24,
                          height: 24,
                          color: isSelected ? Colors.purple : Colors.grey,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        menuItems[index]['text'],
                        style: TextStyle(
                          color: isSelected ? Colors.purple : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Search for Mutual funds ...",
              style: GoogleFonts.notoSans(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Image.asset(
            'lib/assets/icons/search.png',
            width: 50,
            height: 50,
          )
        ],
      ),
    );
  }
}

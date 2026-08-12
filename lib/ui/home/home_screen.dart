import 'package:eslame_assignment/ui/home/tabs/hadeth/hadeth_tab.dart';
import 'package:eslame_assignment/ui/home/tabs/quran/quran_tab.dart';
import 'package:eslame_assignment/ui/home/tabs/radio/radio_tab.dart';
import 'package:eslame_assignment/ui/home/tabs/sebha/sebha_tab.dart';
import 'package:eslame_assignment/ui/home/tabs/time/time_tab.dart';
import 'package:eslame_assignment/utils/app_assets.dart';
import 'package:eslame_assignment/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabList = [
    const QuranTab(),
    const HadethTab(),
    const SebhaTab(),
    const RadioTab(),
    const TimeTab(),
  ];

  final List<String> backgroundImages = [
    AppAssets.background,
    AppAssets.hadethBg,
    AppAssets.sebhaBg,
    AppAssets.radioBg,
    AppAssets.timeBg,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // =========================
        // BACKGROUND
        // =========================
        Positioned.fill(
          child: Image.asset(
            backgroundImages[selectedIndex],
            fit: BoxFit.cover,
          ),
        ),

        // =========================
        // SCAFFOLD
        // =========================
        Scaffold(
          backgroundColor: AppColors.transparentColor,

          // =========================
          // BOTTOM NAVIGATION
          // =========================
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColors.primaryColor,
            ),
            child: BottomNavigationBar(
              selectedItemColor: AppColors.whiteColor,
              unselectedItemColor: AppColors.blackColor,
              currentIndex: selectedIndex,

              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },

              items: [
                builtBottomNavBarItem(
                  icon: AppAssets.ic_quran,
                  label: 'quran',
                  index: 0,
                ),

                builtBottomNavBarItem(
                  icon: AppAssets.ic_hadeth,
                  label: 'hadeth',
                  index: 1,
                ),

                builtBottomNavBarItem(
                  icon: AppAssets.ic_sebha,
                  label: 'sebha',
                  index: 2,
                ),

                builtBottomNavBarItem(
                  icon: AppAssets.ic_radio,
                  label: 'radio',
                  index: 3,
                ),

                builtBottomNavBarItem(
                  icon: AppAssets.ic_time,
                  label: 'time',
                  index: 4,
                ),
              ],
            ),
          ),

          // =========================
          // BODY
          // =========================
          body: SafeArea(
            top: true,
            bottom: false,
            child: Column(
              children: [
                // LOGO
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.contain,
                  ),
                ),

                // TAB
                Expanded(
                  child: tabList[selectedIndex],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem builtBottomNavBarItem({
    required String icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: selectedIndex == index
          ? Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.blackBgColor,
          borderRadius: BorderRadius.circular(66),
        ),
        child: ImageIcon(
          AssetImage(icon),
        ),
      )
          : ImageIcon(
        AssetImage(icon),
      ),
      label: label,
    );
  }
}
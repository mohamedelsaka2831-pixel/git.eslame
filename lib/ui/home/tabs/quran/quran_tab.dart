import 'package:eslame_assignment/utils/app_colors.dart';
import 'package:eslame_assignment/utils/app_style.dart';
import 'package:eslame_assignment/utils/surah_data.dart';
import 'package:flutter/material.dart';

import '../../../../utils/suras_model.dart'; // فيه كلاس Surah
import 'details.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<Surah> _allSurahs = [];
  List<Surah> _filteredSurahs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _allSurahs = buildSurahList();
    _filteredSurahs = _allSurahs;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredSurahs = _allSurahs.where((surah) {
        return surah.nameArabic.contains(query) ||
            surah.nameEnglish.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // فتح شاشة نص السورة كاملة
  void _openSurah(Surah surah) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SurahDetailScreen(surah: surah),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE8C477),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),

                const Image(
                  image: AssetImage(
                    'assets/images/serch_logo.png',
                  ),
                  width: 24,
                  height: 24,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: AppStyle.bold16White,
                    decoration: const InputDecoration(
                      hintText: 'Sura Name',
                      hintStyle: AppStyle.bold16White,
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),

                const SizedBox(width: 12),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        const Padding(
          padding: EdgeInsets.only(left: 21),
          child: Text(
            'Most Recently',
            style: AppStyle.bold16White,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 125,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _recentCard(
                  title: 'Al-Anbiya',
                  arabic: 'الأنبياء',
                  verses: '112 Verses',
                ),

                const SizedBox(width: 8),

                _recentCard(
                  title: 'Al-Fatiha',
                  arabic: 'الفاتحه',
                  verses: '7 Verses',
                ),

                const SizedBox(width: 8),

                _recentCard(
                  title: 'Al-Baqarah',
                  arabic: 'البقرة',
                  verses: '286 Verses',
                ),

                const SizedBox(width: 8),

                _recentCard(
                  title: 'Al-Imran',
                  arabic: 'آل عمران',
                  verses: '200 Verses',
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Sura List',
            style: AppStyle.bold16White,
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final surah = _filteredSurahs[index];
              return _buildSurahTile(surah);
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.white.withOpacity(0.1),
                height: 1,
              );
            },
            itemCount: _filteredSurahs.length,
          ),
        ),
      ],
    );
  }

  Widget _buildSurahTile(Surah surah) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: _buildNumberBadge(surah.number),
      title: Text(
        surah.nameEnglish,
        style: AppStyle.bold20white,
      ),
      subtitle: Text(
        '${surah.numberOfAyahs} Verses',
        style: AppStyle.bold16White,
      ),
      trailing: Text(
        surah.nameArabic,
        style: AppStyle.bold20white,
      ),
      onTap: () => _openSurah(surah),
    );
  }

  Widget _buildNumberBadge(int number) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/sura_logo2.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentCard({
    required String title,
    required String arabic,
    required String verses,
  }) {
    return Container(
      width: 250,
      height: 130,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.bold16Black,
                ),

                Text(
                  arabic,
                  style: AppStyle.regular16black,
                ),

                const Spacer(),

                Text(
                  verses,
                  style: AppStyle.regular12black,
                ),
              ],
            ),
          ),

          Image.asset(
            'assets/images/sura_logo.png',
            width: 90,
            height: 90,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

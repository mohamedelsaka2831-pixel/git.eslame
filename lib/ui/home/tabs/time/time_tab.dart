import 'package:flutter/material.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  static const String _gregorianDate = '16 Jul,\n2024';
  static const String _hijriDate = '09 Muh,\n1446';
  static const String _weekday = 'Tuesday';
  static const String _nextPrayCountdown = '02:32';

  static const List<Map<String, String>> _prayerTimes = [
    {
      'name': 'Sunrise',
      'time': '05:04',
      'period': 'AM',
    },
    {
      'name': 'Dhuhr',
      'time': '01:01',
      'period': 'PM',
    },
    {
      'name': 'ASR',
      'time': '04:38',
      'period': 'PM',
    },
    {
      'name': 'Maghrib',
      'time': '07:57',
      'period': 'PM',
    },
    {
      'name': 'Isha',
      'time': '09:15',
      'period': 'PM',
    },
  ];

  static const int _currentPrayerIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrayerCard(),

            const SizedBox(height: 20),

            const Text(
              'Azkar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _AzkarCard(
                    title: 'Evening Azkar',
                    imagePath: 'assets/images/evening.png',
                    onTap: () {},
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _AzkarCard(
                    title: 'Morning Azkar',
                    imagePath: 'assets/images/morning.png',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF856B3F),
        borderRadius: BorderRadius.circular(22),
        image: const DecorationImage(
          image: AssetImage('assets/images/time_logo.png'),
          fit: BoxFit.cover,

          opacity: 0.12,
          colorFilter: ColorFilter.mode(
            Color(0xFF241B13),
            BlendMode.srcATop,
          ),
        ),
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _gregorianDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF241B13),
                ),
              ),

              Column(
                children: const [
                  Text(
                    'Pray Time',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF241B13),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _weekday,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF241B13),
                    ),
                  ),
                ],
              ),

              Text(
                _hijriDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF241B13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 78,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _prayerTimes.length,
              itemBuilder: (context, index) {
                final prayer = _prayerTimes[index];

                return _PrayerItem(
                  name: prayer['name']!,
                  time: prayer['time']!,
                  period: prayer['period']!,
                  isCurrent: index == _currentPrayerIndex,
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Next Pray - 02:32',
            style: TextStyle(
              fontSize:9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF241B13),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerItem extends StatelessWidget {
  final String name;
  final String time;
  final String period;
  final bool isCurrent;

  const _PrayerItem({
    required this.name,
    required this.time,
    required this.period,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      margin: const EdgeInsets.only(right: 7),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isCurrent
            ? const Color(0xFF2C2118)
            : const Color(0xFFC39B5B),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 2),

          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          Text(
            period,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _AzkarCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _AzkarCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 205,
        decoration: BoxDecoration(
          color: const Color(0xFF171513),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE5C17A),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      color: Colors.white54,
                      size: 45,
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 12,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {

  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingItem {
  final String image;
  final String? title;
  final String subtitle;

  const _OnboardingItem({
    required this.image,
    this.title,
    required this.subtitle,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const List<_OnboardingItem> _pages = [
    _OnboardingItem(
      image: 'assets/images/on1.png',
      subtitle: 'Welcome To Islmi App',
    ),
    _OnboardingItem(
      image: 'assets/images/on2.png',
      title: 'Welcome To Islami',
      subtitle: 'We Are Very Excited To Have You In Our Community',
    ),
    _OnboardingItem(
      image: 'assets/images/on3.png',
      title: 'Reading the Quran',
      subtitle: 'Read, and your Lord is the Most Generous',
    ),
    _OnboardingItem(
      image: 'assets/images/on4.png',
      title: 'Bearish',
      subtitle: 'Praise the name of your Lord, the Most High',
    ),
    _OnboardingItem(
      image: 'assets/images/on5.png',
      title: 'Holy Quran Radio',
      subtitle:
      'You can listen to the Holy Quran Radio through the application for free and easily',
    ),
  ];

  bool get _isLastPage => _currentPage == _pages.length - 1;
  bool get _isFirstPage => _currentPage == 0;

  void _goNext() {
    if (_isLastPage) {
      widget.onFinish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBack() {
    if (!_isFirstPage) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191613),
      body: SafeArea(
        child: Column(
          children: [

            const Padding(
              padding: EdgeInsets.only(top: 12, bottom: 8),
              child: Image(
                image: AssetImage('assets/images/islami_logo.png'),
                height: 110,
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _buildPage(page);
                },
              ),
            ),


            _buildBottomBar(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingItem page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              page.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                color: Colors.white24,
                size: 80,
              ),
            ),
          ),

          const SizedBox(height: 28),

          if (page.title != null) ...[
            Text(
              page.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE5C17A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
          ],

          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: page.title == null
                  ? const Color(0xFFE5C17A)
                  : Color(0xFFE5C17A),
              fontSize: page.title == null ? 16 : 14,
              fontWeight:
              page.title == null ? FontWeight.w600 : FontWeight.normal,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: _isFirstPage
                ? null
                : GestureDetector(
              onTap: _goBack,
              child: const Text(
                'Back',
                style: TextStyle(color: Color(0xFFE5C17A), fontSize: 14),
              ),
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                final isActive = index == _currentPage;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 6,
                  width: isActive ? 20 : 6,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFE5C17A)
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

          SizedBox(
            width: 60,
            child: GestureDetector(
              onTap: _goNext,
              child: Text(
                _isLastPage ? 'Finish' : 'Next',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFFE5C17A),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
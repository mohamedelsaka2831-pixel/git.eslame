import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../utils/suras_model.dart'; // فيه كلاس Surah

class SurahDetailScreen extends StatefulWidget {
  final Surah surah;

  const SurahDetailScreen({super.key, required this.surah});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  List<String> _ayahs = [];
  bool _isLoading = true;
  String? _error;

  bool _isBoxedView = false;

  int? _selectedAyahIndex;

  @override
  void initState() {
    super.initState();
    _loadSurahText();
  }

  Future<void> _loadSurahText() async {
    try {
      final raw = await rootBundle.loadString(
        'assets/quran/${widget.surah.number}.txt',
      );

      final cleaned = raw.replaceAll('\uFEFF', '');
      final lines = cleaned
          .split('\n')
          .map((line) => line.replaceAll('\r', '').trim())
          .where((line) => line.isNotEmpty)
          .toList();

      setState(() {
        _ayahs = lines;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'تعذر تحميل نص السورة';
        _isLoading = false;
      });
    }
  }

  void _toggleView() {
    setState(() {
      _isBoxedView = !_isBoxedView;
      _selectedAyahIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171513),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/mosco.png',
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
                ),
              ),
            ),

            Column(
              children: [
                _buildAppBar(),

                const SizedBox(height: 6),

                _buildTitleWithCorners(),

                const SizedBox(height: 20),

                Expanded(child: _buildBody()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          Expanded(
            child: Text(
              widget.surah.nameEnglish,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildTitleWithCorners() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [

          Image.asset(
            'assets/images/lift.png',
            width: 46,
            height: 46,
            errorBuilder: (context, error, stackTrace) =>
            const SizedBox(width: 46, height: 46),
          ),

          Expanded(
            child: Text(
              widget.surah.nameArabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE5C17A),
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),


          Image.asset(
            'assets/images/righte.png',
            width: 46,
            height: 46,
            errorBuilder: (context, error, stackTrace) =>
            const SizedBox(width: 46, height: 46),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFE5C17A)),
      );
    }

    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.white70)),
      );
    }

    return GestureDetector(

      onLongPress: _toggleView,
      behavior: HitTestBehavior.opaque,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: _isBoxedView ? _buildBoxedView() : _buildParagraphView(),
        ),
      ),
    );
  }


  Widget _buildParagraphView() {
    return Text.rich(
      TextSpan(children: _buildParagraphSpans()),
      textAlign: TextAlign.center,
    );
  }

  List<InlineSpan> _buildParagraphSpans() {
    final spans = <InlineSpan>[];

    for (var i = 0; i < _ayahs.length; i++) {
      spans.add(
        TextSpan(
          text: '${_ayahs[i]} ',
          style: const TextStyle(
            color: Color(0xFFDDBD86),
            fontSize: 19,
            height: 2.0,
          ),
        ),
      );

      spans.add(
        TextSpan(
          text: '[${i + 1}] ',
          style: const TextStyle(
            color: Color(0xFFDDBD86),
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return spans;
  }


  Widget _buildBoxedView() {
    return Column(
      children: List.generate(_ayahs.length, (index) {
        final isSelected = _selectedAyahIndex == index;

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedAyahIndex = isSelected ? null : index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE5C17A) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFE5C17A),
                  width: 1.2,
                ),
              ),
              child: Text(
                '[${index + 1}] ${_ayahs[index]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF241B13) : const Color(0xFFDDBD86),
                  fontSize: 18,
                  height: 1.6,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
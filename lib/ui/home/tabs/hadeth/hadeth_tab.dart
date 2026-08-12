import 'package:eslame_assignment/ui/home/tabs/hadeth/repository.dart';
import 'package:flutter/material.dart';
import 'hadeth2.dart';
import 'model.dart';

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  late Future<List<HadethModel>> _hadethFuture;
  final PageController _pageController = PageController(viewportFraction: 0.92);

  @override
  void initState() {
    super.initState();
    _hadethFuture = HadethRepository.loadHadeth();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HadethModel>>(
      future: _hadethFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('حصل خطأ: ${snapshot.error}'));
        }

        final list = snapshot.data!;
        return PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            final hadeth = list[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HadethDetailsScreen(hadeth: hadeth),
                    ),
                  );
                },
                child: _HadethCard(hadeth: hadeth),
              ),
            );
          },
        );
      },
    );
  }
}

class _HadethCard extends StatelessWidget {
  final HadethModel hadeth;
  const _HadethCard({required this.hadeth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          // preview card background (the golden parchment card)
          image: AssetImage('assets/images/hadeth_logo.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        // leaves room so text doesn't overlap the ornate corner decorations
        padding: const EdgeInsets.fromLTRB(28, 90, 28, 70),
        // SingleChildScrollView instead of a fixed Column prevents the
        // "BOTTOM OVERFLOWED" error when a hadeth's text is long
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                hadeth.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2A12),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                hadeth.text,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.7,
                  color: Color(0xFF3E2A12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
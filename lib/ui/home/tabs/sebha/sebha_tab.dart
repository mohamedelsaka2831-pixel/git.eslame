import 'dart:math' as math;

import 'package:flutter/material.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab>
    with SingleTickerProviderStateMixin {
  int count = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      count++;

      if (count > 99) {
        count = 1;
      }
    });

    _controller.forward(from: 0);
  }

  String get zekr {
    if (count <= 33) {
      return 'سبحان الله';
    } else if (count <= 66) {
      return 'الحمدلله';
    } else {
      return 'الله أكبر';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _incrementCounter,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text('سَبِّحِ اسْمَ رَبِّكَ الأعلى',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),



          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [

                  RotationTransition(
                    turns: Tween<double>(
                      begin: 0,
                      end: 1 / 33,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/tasbeeh.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: -50,
                    child: Image.asset(
                      'assets/images/tasbeeh_head.png',
                      width: 65,
                      height: 65,
                      fit: BoxFit.contain,
                    ),
                  ),


                  Positioned(
                    top: 70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(
                          zekr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
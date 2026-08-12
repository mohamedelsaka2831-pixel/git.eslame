import 'package:flutter/material.dart';
import 'model.dart';

class HadethDetailsScreen extends StatelessWidget {
  final HadethModel hadeth;
  const HadethDetailsScreen({super.key, required this.hadeth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Hadith ${hadeth.id}',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // dark background with ornate corners + mosque silhouette
            image: AssetImage('assets/images/hadeth_logo2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 320),
            // extra bottom padding keeps text clear of the mosque silhouette
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  hadeth.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9B36C),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  hadeth.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.9,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  hadeth.source,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
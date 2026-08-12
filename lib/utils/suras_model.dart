class Surah {
  final int number;              // رقم السورة (1 -> 114)
  final String nameArabic;       // الاسم بالعربي "الفاتحة"
  final String nameEnglish;      // الاسم بالإنجليزي "Al-Fatiha"
  final int numberOfAyahs;       // عدد الآيات

  Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.numberOfAyahs,
  });

  // بيحول عنصر الـ JSON لكائن Surah
  // عدّل أسماء المفاتيح هنا لو ملفك بيسميهم بشكل مختلف
  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'] ?? json['id'],
      nameArabic: json['name'] ?? json['arabicName'] ?? '',
      nameEnglish: json['englishName'] ?? json['name_en'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? json['ayahs'] ?? 0,
    );
  }
}

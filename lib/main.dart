import 'package:flutter/material.dart';

// Main entry point for the Flutter application
void main() {
  runApp(const QuranApp());
}

// The root widget of the application
class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Tajawal', // Assuming a custom font for Arabic
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// A data class for Azkar items
class Zikr {
  final int id;
  final String text;
  final String title;
  final int count;
  final String reference;
  final String benefit;

  const Zikr({
    required this.id,
    required this.text,
    required this.title,
    required this.count,
    required this.reference,
    required this.benefit,
  });
}

// Data migrated from azkar.js
const List<Zikr> morningAzkar = [
  Zikr(id: 8, text: 'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ ﷺ نَبِيًّا', title: 'الرضا', count: 3, reference: 'أبو داود', benefit: 'كان حقاً على الله أن يُرضيه يوم القيامة'),
  Zikr(id: 5, text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ', title: 'دعاء العفو', count: 1, reference: 'ابن ماجه', benefit: 'من أجمع الأدعية في الخير'),
];

// The home screen of the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'أذكار الصباح',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: morningAzkar.length,
                itemBuilder: (context, index) {
                  final zikr = morningAzkar[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(zikr.text, style: const TextStyle(fontSize: 18), textAlign: TextAlign.right,),
                      subtitle: Text(zikr.title, textAlign: TextAlign.right,),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text('${zikr.count}', style: const TextStyle(color: Colors.white),),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

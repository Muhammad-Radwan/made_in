import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:made_in/model/country_code.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // محاكاة لقاعدة بيانات مصغرة وهي عبارة عن
  // list
  // country code من العنصر
  List<CountryCode> db = [
    CountryCode(code: 528, countryName: 'لبنان'),
    CountryCode(code: 608, countryName: 'البحرين'),
    CountryCode(code: 611, countryName: 'المغرب'),
    CountryCode(code: 613, countryName: 'الجزائر'),
    CountryCode(code: 619, countryName: 'تونس'),
    CountryCode(code: 621, countryName: 'سوريا'),
    CountryCode(code: 622, countryName: 'مصر'),
    CountryCode(code: 624, countryName: 'ليبيا'),
    CountryCode(code: 625, countryName: 'الأردن'),
    CountryCode(code: 627, countryName: 'الكويت'),
    CountryCode(code: 628, countryName: 'السعودين'),
    CountryCode(code: 629, countryName: 'الإمارات'),
    CountryCode(code: 100, countryName: 'الولايات المتحدة'),
    CountryCode(code: 400, countryName: 'ألمانيا'),
    CountryCode(code: 300, countryName: 'فرنسا'),
    CountryCode(code: 490, countryName: 'اليابان'),
    CountryCode(code: 500, countryName: 'المملكة المتحدة'),
  ];

  // متغير نصي يحمل نتيجة البحث بعد قراءة الباركود
  String? finalResult;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // نستخدم علامات الاستفهام المزدوجة في حالة توقع وجوة قيمة فارغة
              Text(
                finalResult ?? 'لم يتم العثور على نتيجة',
                style: const TextStyle(fontSize: 30),
              ),

              ElevatedButton(
                  onPressed: () => scanBarcode(), child: const Text('Scan')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
    try {
      //متغير يحمل قيمة الباركود بعد القراءة عت طريق الكاميرا
      String? barcodeResult = await FlutterBarcodeScanner.scanBarcode(
          'blue', 'إلغاء', false, ScanMode.BARCODE);

      //نقوم باستخراج أول ثلاثة أرقام من الباركود
      String countryCode = barcodeResult.substring(0, 3);

      //نقوم بالبحث داخل قاعدة البيانات المصغرة ونخزن في متغير من نوع
      //Country Code
      CountryCode code =
          db.where((c) => c.code == int.parse(countryCode)).first;

      // refresh للويدجت
      setState(() {
        finalResult = code.countryName;
      });
    } catch (e) {
      //في حالة وجود خطأ يتم طباعته في الكونسول
      // و في النص الأساسي  في التطبيق
      setState(() {
        finalResult = e.toString();
      });
      print(e.toString());
    }
  }
}

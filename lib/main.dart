import 'package:flutter/material.dart';
import 'package:rra_mobile/page/justapage.dart';
import 'package:rra_mobile/page/noti.dart';
import 'package:rra_mobile/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 67, 122)),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/noti': (context) => const Noti(),
        '/mrr': (context) =>
            const JustAPage(title: 'Mengenai Respons Rakyat', num: 0),
        '/ta': (context) =>
            const JustAPage(title: 'Takrifan Aduan/Maklum Balas', num: 1),
        '/bk': (context) => const JustAPage(title: 'Bidang Kuasa', num: 2),
        '/mbpa': (context) => const JustAPage(title: 'Mengenai BPA', num: 3),
        '/tnc': (context) => const JustAPage(title: 'Terma & Syarat', num: 4),
        '/call': (context) => const JustAPage(title: 'Hubungi Kami', num: 5),
      },
    );
  }
}

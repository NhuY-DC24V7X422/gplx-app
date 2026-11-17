import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';
import 'theme.dart';

// Widget gốc của app: gắn theme, router và ngôn ngữ tiếng Việt.
class GplxApp extends StatefulWidget {
  const GplxApp({super.key});

  @override
  State<GplxApp> createState() => _GplxAppState();
}

class _GplxAppState extends State<GplxApp> {
  // tạo router 1 lần, không tạo lại mỗi lần build
  late final GoRouter _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GPLX Pro',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ThemeMode.system, // theo cài đặt sáng/tối của máy
      // ngôn ngữ: chữ của các widget có sẵn (lịch, nút OK...) hiện tiếng Việt
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

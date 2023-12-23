import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:money_note/state/main/main_notifier.dart';
import 'package:path_provider/path_provider.dart';

import 'collections/bank_name.dart';
import 'collections/bank_price.dart';
import 'collections/emoney_name.dart';
import 'collections/income.dart';
import 'collections/money.dart';
import 'collections/spend_time_place.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();

  final isar = await Isar.open([
    BankNameSchema,
    BankPriceSchema,
    EmoneyNameSchema,
    IncomeSchema,
    MoneySchema,
    SpendTimePlaceSchema,
  ], directory: dir.path);

  runApp(ProviderScope(child: MyApp(isar: isar)));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, required this.isar});

  final Isar isar;

  ///
  Future<void> init({required WidgetRef ref}) async {
    ref.read(mainProvider.notifier).setIsar(isar: isar);
  }

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() => init(ref: ref));

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.kiwiMaru(textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
        ),
        useMaterial3: false,
        colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark),
        fontFamily: 'KiwiMaru',
      ),
      themeMode: ThemeMode.dark,
      title: 'money note',
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: HomeScreen(),
      ),
    );
  }
}

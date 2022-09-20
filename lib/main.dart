import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';
import 'package:student_db/provider/provider_delete.dart';
import 'package:student_db/provider/provider_image.dart';
import 'package:student_db/provider/provider_search.dart';
// import 'package:student_db/provider/provider_Add.dart';
import 'package:student_db/screens/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider<ProviderDelete>(create: (_) => ProviderDelete()),
        ChangeNotifierProvider<ProviderImage>(create: (_) => ProviderImage()),
        ChangeNotifierProvider<DbFunctionProvider>(
            create: (_) => DbFunctionProvider()),
        ChangeNotifierProvider<ProviderSearch>(create: (_) => ProviderSearch()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Database',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ScreenHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

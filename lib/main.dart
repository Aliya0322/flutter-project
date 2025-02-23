import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'api/api_config.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: ApiConfig.projectURL,
    anonKey: ApiConfig.projectKEY,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData(context),
      title: 'ToDo App',
      home: MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
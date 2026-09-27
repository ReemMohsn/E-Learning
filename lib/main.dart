import 'package:e_learning/core/dependency_injection/injection_container.dart';
import 'package:e_learning/core/networking/supabase_service.dart';
import 'package:e_learning/core/routing/app_router.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/e_learning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await SupabaseService.initil();
  await initDependencies();

  runApp(ELearningApp(appRouter: AppRouter(), initialRoute: Routes.login));
  FlutterNativeSplash.remove();
}

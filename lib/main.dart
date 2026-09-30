import 'package:e_learning/core/routing/app_router.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/e_learning.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ELearningApp(appRouter: AppRouter(), initialRoute: Routes.home));
}

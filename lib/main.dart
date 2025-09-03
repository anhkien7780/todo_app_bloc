import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/configs/app_env_config.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';

import 'app.dart';

void main() async {
  AppConfigs.env = Environment.prod;
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseServices.supabaseInit();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    if(token != null){
      log("Token: ${token.toString()}");
    }
  }
  runApp(const MyApp());
}
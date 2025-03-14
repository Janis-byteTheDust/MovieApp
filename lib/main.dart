import 'package:flutter/material.dart';
import 'package:movie_app/dashboard.dart';
import 'package:movie_app/loginview.dart';
import 'package:movie_app/movie_view.dart';

import 'package:movie_app/pesan_view.dart';
import 'package:movie_app/register_user_view.dart';



void main() {
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/': (context) => RegisterUserView(),
      '/login': (context) => Loginview(),
      '/dashboard': (context) => DashboardView(),
      '/pesan': (context) => PesanView(),
      '/movie': (context) => MovieView(),
      
    },
  ));
}

import 'package:flutter/material.dart';
import 'package:project/product_list_screen.dart';

class CurdApp extends StatelessWidget {
  const CurdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
      themeMode: ThemeMode.light,
      home: ProductListScreen(),
    );
  }

  ThemeData _lightThemeData(){
    return ThemeData(
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple,width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,width: 3),
        ),

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(double.maxFinite),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.purple,
        ),
      ),
    );
  }

  ThemeData _darkThemeData(){
    return ThemeData(
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple,width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,width: 3),
        ),

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(double.maxFinite),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.purple,
        ),
      ),
    );
  }
}
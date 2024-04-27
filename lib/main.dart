import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:state_full_widget/api/api_service.dart';
import 'package:state_full_widget/screen/home.dart';
import 'package:get/get.dart';
 
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dio dio=Dio();
    // dio.transformer = FlutterTransformer();
    // dio.interceptors.add(LogInterceptor(
    //   responseBody: true,
    //   logPrint: (object) => print(object),
    // ));
    ApiService apiService=ApiService(dio);
    Get.put(apiService);
    return const GetMaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:retrofit/http.dart';
import'package:dio/dio.dart';
import 'package:state_full_widget/model/country.dart';
import 'package:state_full_widget/model/detail.dart';
part'api_service.g.dart';
@RestApi(baseUrl: 'https://restcountries.com/v2/')
abstract class ApiService{
  factory ApiService(Dio dio)=_ApiService;

@GET('all')
  Future<List<Country>> getCountries();

@GET('name/{name}?fullText=true')
Future<List<Detail>> getDeatil(@Path() String name);
}
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:task/Model/model.dart';
part 'api_services.g.dart';
@RestApi(baseUrl: 'https://newsapi.org/v2/')
@JsonSerializable()

abstract class ApiServices{
  factory ApiServices(Dio dio ,{String baseUrl}) = _ApiServices;
  @GET('/top-headlines?sources=bbc-news&apiKey=84850f07ea454080958d73a3f1ffeabe')
  Future<HeadLineModel> getPosts(String filter);
}
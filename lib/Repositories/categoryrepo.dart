import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:task/Model/categoryMode.dart';
import 'package:task/Model/model.dart';
part 'categoryrepo.g.dart';
@RestApi(baseUrl: 'https://newsapi.org/v2/')
@JsonSerializable()
abstract class CategoryRepo{
  factory CategoryRepo(Dio dio ,{String baseUrl}) = _CategoryRepo;
  @GET('/everything?q=flutter&apiKey=84850f07ea454080958d73a3f1ffeabe')
  Future<CategoryModel> getPosts(String text);
}
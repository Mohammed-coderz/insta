import 'package:untitled7/feature/home/models/categories_model.dart';

abstract class GetCategoriesState {}

class OnInitialGetCategoriesState extends GetCategoriesState {}

class OnStartGetCategoriesState extends GetCategoriesState {}

class OnLoadedGetCategoriesState extends GetCategoriesState {
  CategoriesModel categories;
  OnLoadedGetCategoriesState({required this.categories});
}

class OnErrorGetCategoriesState extends GetCategoriesState {
  final String errorMessage;

  OnErrorGetCategoriesState(this.errorMessage);
}

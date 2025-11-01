import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/const/api_const.dart';
import '../models/categories_model.dart';
import '../state/get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(OnInitialGetCategoriesState());

  static GetCategoriesCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void GetCategories() async {
    emit(OnStartGetCategoriesState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? 'No Token';

      final response = await http.get(
        Uri.parse(ApiConst.getCategories),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final CategoriesModel categories = CategoriesModel.fromJson(json);
        print(json);
        if (json["result"] == true) {
          emit(OnLoadedGetCategoriesState(categories: categories));
        } else {
          emit(
            OnErrorGetCategoriesState(
              json["message"] ?? "something went wrong",
            ),
          );
        }
      } else {
        emit(OnErrorGetCategoriesState("Server error: ${response.statusCode}"));
      }
    } catch (error) {
      emit(OnErrorGetCategoriesState("Error: $error"));
    }
  }
}

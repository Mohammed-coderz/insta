import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/feature/home/state/get_categories_state.dart';

import '../cubit/get_categories_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetCategoriesCubit>().GetCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: Center(
        child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
          builder: (context, state) {
            if (state is OnStartGetCategoriesState) {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is OnLoadedGetCategoriesState) {
              return GridView.builder(
                itemCount: state.categories.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  if (state.categories.data!.isEmpty) {
                    return Center(child: Text("No Data"));
                  }
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          state.categories.data![index].image ?? "",
                        ),
                        Text(state.categories.data![index].name ?? ""),
                        Text(state.categories.data![index].description ?? ""),
                      ],
                    ),
                  );
                },
              );
            }
            else if (state is OnErrorGetCategoriesState) {
              return Center(
                child: Column(
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GetCategoriesCubit>().GetCategories();
                      },
                      child: Text("try again"),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text("Api didnt called"));
          },
        ),
      ),
    );
  }
}

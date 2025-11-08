import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/feature/auth/domain/use_cases/signup_usecase.dart';
import 'package:untitled7/feature/splash/splash.dart';

import 'feature/auth/data/datasource/auth_remote_datasource.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/domain/use_cases/login_usecase.dart';
import 'feature/auth/presentation/login/cubit/login_cubit.dart';
import 'feature/auth/presentation/signup/cubit/signup_cubit.dart';
import 'feature/home/cubit/get_categories_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthRepository authRepository = AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            loginUseCase: LoginUseCase(loginRepository: authRepository),
          ),
        ),
        BlocProvider(
          create: (context) => SignupCubit(
            signupUseCase: SignupUsecase(authRepository: authRepository),
          ),
        ),
        BlocProvider(create: (context) => GetCategoriesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: Splash(),
      ),
    );
  }
}

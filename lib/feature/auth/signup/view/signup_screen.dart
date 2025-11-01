import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/core/const/svg_constant.dart';
import 'package:untitled7/feature/auth/login/view/login_screen.dart';

import '../cubit/Signup_cubit.dart';
import '../state/Signup_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRememberMe = false;
  bool _obscure = true;


  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final height = media.size.height;
    final width = media.size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
                colors: [
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                  Color(0xFF90CAF9),
                ],
              ),
            ),
          ),

          // content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width * 0.9),
                child: Card(
                  elevation: 12,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.03,
                    ),
                    child: BlocConsumer<SignupCubit, SignupStates>(
                      listener: (context, state) async {
                        if (state is OnLoadedSignupState) {


                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Welcome!")),
                            );
                          }

                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ),
                            );
                          }
                        }
                        if (state is OnErrorSignupState) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is OnStartSignupState;

                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: height * 0.01),
                              SvgPicture.asset(
                                SvgConstant.logo,
                                height: height * 0.12,
                              ),
                              SizedBox(height: height * 0.02),

                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  fontSize: height * 0.03,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: height * 0.03),

                              // email/phone
                              TextFormField(
                                controller: usernameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "username",
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.02),
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Phone",
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.02),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Email or Phone",
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.02),

                              // password
                              TextFormField(
                                controller: passwordController,
                                obscureText: _obscure,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        setState(() => _obscure = !_obscure),
                                    icon: Icon(
                                      _obscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "This field is required";
                                  }
                                  if (v.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) =>
                                    _onSignupPressed(context, isLoading),
                              ),
                              SizedBox(height: height * 0.015),
                              SizedBox(
                                width: double.infinity,
                                height: height * 0.065,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () =>
                                      _onSignupPressed(context, isLoading),
                                  child: isLoading
                                      ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                      : Text(
                                    "Signup",
                                    style: TextStyle(
                                      fontSize: height * 0.022,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("already have an account?"),
                                  TextButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                          const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text("login"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // subtle loading overlay
          BlocBuilder<SignupCubit, SignupStates>(
            builder: (context, state) {
              final isLoading = state is OnStartSignupState;
              if (!isLoading) return const SizedBox.shrink();
              return Container(
                height: height,
                width: width,
                color: Colors.black.withOpacity(0.08),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSignupPressed(BuildContext context, bool isLoading) {
    if (isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = emailController.text.trim();
    final pass = passwordController.text;
    final phone = phoneController.text;
    final username = usernameController.text;

    context.read<SignupCubit>().Signup(context, username, email,phone,pass);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/core/const/svg_constant.dart';
import '../../../../main/view/main_screen.dart';
import '../../signup/view/signup_screen.dart';
import '../cubit/login_cubit.dart';
import '../state/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRememberMe = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final remembered = prefs.getBool('isRememberMe') ?? false;
    setState(() => isRememberMe = remembered);
    if (remembered) {
      emailController.text = prefs.getString('savedEmail') ?? '';
      passwordController.text = prefs.getString('savedPassword') ?? '';
    }
  }

  Future<void> _persistRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRememberMe', isRememberMe);
    if (isRememberMe) {
      await prefs.setString('savedEmail', emailController.text.trim());
      await prefs.setString('savedPassword', passwordController.text);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final height = media.size.height;
    final width = media.size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Login"),
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
                    child: BlocConsumer<LoginCubit, LoginStates>(
                      listener: (context, state) async {
                        if (state is OnLoadedLoginState) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('accessToken', state.token);
                          String Token = prefs.getString('accessToken') ?? 'No Token';
                          print("Token is : $Token");
                          await _persistRememberMe();

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Welcome!")),
                            );
                          }

                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>  MainScreen(),
                              ),
                            );
                          }
                        }
                        if (state is OnErrorLoginState) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is OnStartLoginState;

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
                                    _onLoginPressed(context, isLoading),
                              ),
                              SizedBox(height: height * 0.015),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isRememberMe,
                                    onChanged: isLoading
                                        ? null
                                        : (v) => setState(
                                            () => isRememberMe = v ?? false,
                                          ),
                                  ),
                                  const Text("Remember me"),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: isLoading ? null : () {},
                                    child: const Text("Forgot password?"),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              SizedBox(
                                width: double.infinity,
                                height: height * 0.065,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () =>
                                            _onLoginPressed(context, isLoading),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Login",
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
                                  const Text("Don't have an account?"),
                                  TextButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const SignupScreen(),
                                              ),
                                            );
                                          },
                                    child: const Text("Signup"),
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
          BlocBuilder<LoginCubit, LoginStates>(
            builder: (context, state) {
              final isLoading = state is OnStartLoginState;
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

  void _onLoginPressed(BuildContext context, bool isLoading) {
    if (isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = emailController.text.trim();
    final pass = passwordController.text;

    context.read<LoginCubit>().login(context, email, pass);
  }
}

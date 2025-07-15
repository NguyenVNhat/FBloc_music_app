import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/common/widgets/appbars/app_bar.dart';
import 'package:flutter_bloc_project/common/widgets/buttons/basic_button.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/data/models/auth/create_user_request.dart';
import 'package:flutter_bloc_project/domain/usecases/auth/signup.dart';
import 'package:flutter_bloc_project/main.dart';
import 'package:flutter_bloc_project/presentation/auth/pages/signin.dart';
import 'package:flutter_bloc_project/service_locator.dart';
import 'package:flutter_svg/svg.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: BasicAppBar(
          title: SvgPicture.asset(AppImages.spotifyLogo, height: 40, width: 40),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              spacing: 20,
              children: [
                _registerText(),
                _supportText(context),
                _fullNameFieldText(context),
                _emailFieldText(context),
                _passwordFieldText(context),
                BasicButton(
                  onPressed: () async {
                    var result = await sl<SignupUseCase>().call(
                      params: CreateUserRequest(
                        fullName: _fullName.text,
                        email: _email.text,
                        password: _password.text,
                      ),
                    );
                    result.fold(
                      (l) {
                        var snackbar = SnackBar(content: Text(l));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (r) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainNavigation(onSwitchToAdmin: () {})),
                          (route) => false,
                        );
                      },
                    );
                  },
                  title: "Create Account",
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _signInText(context),
      ),
    );
  }

  Widget _registerText() {
    return Text(
      "Register",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

  Widget _supportText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "If You Need Any Support ",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: context.isDarkMode ? Colors.white : AppColors.grey,
        ),
        children: [
          TextSpan(
            text: "Click Here",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }

  Widget _fullNameFieldText(BuildContext context) {
    return TextField(
      controller: _fullName,
      cursorColor: context.isDarkMode ? Colors.white : AppColors.grey,
      decoration: InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailFieldText(BuildContext context) {
    return TextField(
      controller: _email,
      cursorColor: context.isDarkMode ? Colors.white : AppColors.grey,
      decoration: InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordFieldText(BuildContext context) {
    return TextField(
      controller: _password,
      cursorColor: context.isDarkMode ? Colors.white : AppColors.grey,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Do you have an account? ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: Text("Sign In", style: TextStyle(color: Color(0xFF288CE9))),
          ),
        ],
      ),
    );
  }
}

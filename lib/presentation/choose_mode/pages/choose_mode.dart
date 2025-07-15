import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/widgets/buttons/basic_button.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/presentation/auth/pages/signup_or_signin.dart';
import 'package:flutter_bloc_project/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter_svg/svg.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.introBg),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.15)),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppImages.spotifyLogo),
                ),
                Spacer(),
                Text(
                  "Choose Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 71,
                  children: [
                    Column(
                      spacing: 20,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(
                                  ThemeMode.dark,
                                );
                          },
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                width: 73,
                                height: 73,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(
                                    0xFF30393C,
                                  ).withValues(alpha: 0.5),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImages.iconDarkMode,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 20,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(
                                  ThemeMode.light,
                                );
                          },
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                width: 73,
                                height: 73,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(
                                    0xFF30393C,
                                  ).withValues(alpha: 0.5),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImages.iconLightMode,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Light Mode",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                BasicButton(
                  title: "Continue",
                  onPressed: () {
                    print('Continue button pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SignupOrSigninPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

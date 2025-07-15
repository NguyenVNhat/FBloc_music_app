import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/presentation/chat/pages/chat.dart';
import 'package:flutter_bloc_project/presentation/notification/pages/notification.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: SafeArea(
        child: Row(
          spacing: 8,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.grey.withValues(alpha: 0.5),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://vcdn1-dulich.vnecdn.net/2021/07/16/3-1-1626444927.jpg?w=460&h=0&q=100&dpr=1&fit=crop&s=jT_THL7zlbfk2i9eaVXL9Q'),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Zoyden",
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Gold Member",
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
              icon: SvgPicture.asset(AppImages.iconMessage,
                  colorFilter: ColorFilter.mode(
                    context.isDarkMode ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()),
                );
              },
              icon: SvgPicture.asset(AppImages.iconNotification,
                  colorFilter: ColorFilter.mode(
                    context.isDarkMode ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_svg/svg.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            child: Text(
              "Listen The Latest Musics",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.isDarkMode ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: IconButton(
              onPressed: () {},
              icon: Row(
                children: [
                  SvgPicture.asset(AppImages.iconSearch,
                      colorFilter: ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                      height: 24),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Search Music',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

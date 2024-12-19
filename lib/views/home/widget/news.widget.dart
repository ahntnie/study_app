import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNewsItem(Icons.school, 'Tin tức 1', 'Gần đây', AppColor.blue),
        Divider(),
        _buildNewsItem(Icons.school, 'Tin tức 1', 'Gần đây', AppColor.blue),
        Divider(),
        _buildNewsItem(Icons.school, 'Tin tức 1', 'Gần đây', AppColor.blue),
        Divider(),
        _buildNewsItem(Icons.school, 'Tin tức 1', 'Gần đây', AppColor.blue),
      ],
    );
  }
}

Widget _buildNewsItem(
    IconData icon, String headline, String subheadline, Color color) {
  final themeService = GetIt.instance<ThemeService>();
  final isDarkMode = themeService.isDarkMode;

  final colorCard =
      isDarkMode ? const Color.fromARGB(255, 45, 43, 43) : AppColor.extraColor;

  return Card(
    color: colorCard,
    elevation: 1,
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 30,
                color: color,
              ),
              Text(
                'news'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            headline,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subheadline,
                style: TextStyle(),
              ),
              Icon(
                Icons.launch,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

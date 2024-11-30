import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';

class BasePage extends StatefulWidget {
  final bool showLogo;
  final bool showSearch;
  final bool showMore;
  final String? title;
  final bool showLogout;
  final bool showAppBar;
  final Widget body;
  final Widget? bottomNav;
  final bool showLeading;
  final VoidCallback? onPressedLeading;
  final Widget? bottomSheet;
  final Widget? floating;
  const BasePage({
    super.key,
    this.showMore = false,
    this.showLogo = false,
    this.showSearch = false,
    this.title,
    this.floating,
    this.showLogout = false,
    this.showAppBar = true,
    this.bottomSheet,
    required this.body,
    this.bottomNav,
    this.showLeading = true,
    this.onPressedLeading,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floating,
      backgroundColor: AppColor.extraColor,
      appBar: widget.showAppBar
          ? AppBar(
              toolbarHeight: 70,
              backgroundColor: AppColor.appBarColor,
              iconTheme: const IconThemeData(
                color: AppColor
                    .extraColor, // Thay đổi màu của nút back thành màu trắng
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title ?? '',
                      style: GoogleFonts.aBeeZee(
                          color: AppColor.extraColor,
                          fontWeight: FontWeight.w800)),
                  if (widget.showSearch)
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: AppColor.extraColor,
                        size: 40,
                      ),
                      onPressed: () {
                        // Xử lý khi người dùng nhấn vào biểu tượng tìm kiếm
                        print("Search icon pressed");
                      },
                    ),
                  if (widget.showMore)
                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz,
                        color: AppColor.extraColor,
                        size: 30,
                      ),
                      onPressed: () {
                        // Xử lý khi người dùng nhấn vào biểu tượng tìm kiếm
                      },
                    ),
                ],
              ),
            )
          : null,
      body: widget.body,
      bottomNavigationBar: widget.bottomNav,
      bottomSheet: widget.bottomSheet,
    );
  }
}

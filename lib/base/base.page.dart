import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';

class BasePage extends StatefulWidget {
  final bool showLogo;
  final bool showSearch;
  final bool showMore;

  final bool showFinal;
  final bool showAdd;
  final String? title;
  final bool showLogout;
  final bool showAppBar;
  final VoidCallback? onTap;
  final VoidCallback? onTapAdd;
  final Widget body;
  final Widget? bottomNav;
  final bool showLeading;
  final VoidCallback? onPressedLeading;
  final Widget? bottomSheet;
  final Widget? floating;
  final FloatingActionButtonLocation? locationFloating;
  final bool? extendBody;
  const BasePage({
    super.key,
    this.locationFloating,
    this.showFinal = false,
    this.extendBody,
    this.showMore = false,
    this.showAdd = false,
    this.onTapAdd,
    this.onTap,
    this.showLogo = false,
    this.showSearch = false,
    this.title,
    this.floating,
    this.showLogout = false,
    this.showAppBar = true,
    this.bottomSheet,
    required this.body,
    this.bottomNav,
    this.showLeading = false,
    this.onPressedLeading,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final themeService = GetIt.instance<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: themeService,
        builder: (context, _) {
          final isDarkMode = themeService.isDarkMode;

          // Màu động dựa trên theme
          final backgroundColor = isDarkMode ? Colors.black : Colors.white;
          final appBarColor = isDarkMode ? Colors.grey[900] : Colors.blue;
          return Scaffold(
            // extendBody: true,
            floatingActionButton: widget.floating,
            backgroundColor: backgroundColor,
            appBar: widget.showAppBar
                ? AppBar(
                    automaticallyImplyLeading: widget.showLeading,
                    toolbarHeight: 70,
                    backgroundColor: appBarColor,
                    iconTheme: const IconThemeData(
                      color: AppColor.extraColor,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title ?? '',
                            style: TextStyle(
                              color: AppColor.extraColor,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.showMore)
                          IconButton(
                            icon: Icon(
                              Icons.more_horiz,
                              color: AppColor.extraColor,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        if (widget.showAdd)
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: AppColor.extraColor,
                                size: 30,
                              ),
                              onPressed: widget.onTapAdd),
                        if (widget.showFinal)
                          IconButton(
                              icon: Icon(
                                Icons.check,
                                color: AppColor.extraColor,
                                size: 30,
                              ),
                              onPressed: widget.onTap),
                        if (widget.showLogout)
                          IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: AppColor.extraColor,
                                size: 30,
                              ),
                              onPressed: widget.onTap),
                      ],
                    ),
                  )
                : null,
            body: widget.body,
            bottomNavigationBar: widget.bottomNav,
            bottomSheet: widget.bottomSheet,
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart'; // Import thư viện
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';

import 'dart:math';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/flash_card.model.dart';

class FullScreenFlashcardsPage extends StatefulWidget {
  final List<FlashCardModel> lstFlashCard;
  final int initialIndex;

  const FullScreenFlashcardsPage({
    Key? key,
    required this.lstFlashCard,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _FullScreenFlashcardsPageState createState() =>
      _FullScreenFlashcardsPageState();
}

class _FullScreenFlashcardsPageState extends State<FullScreenFlashcardsPage>
    with TickerProviderStateMixin {
  late List<bool> _isFrontList;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _isFrontList = List<bool>.filled(widget.lstFlashCard.length, true);
    _controllers = List<AnimationController>.generate(
      widget.lstFlashCard.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
    _animations = _controllers
        .map(
            (controller) => Tween<double>(begin: 0, end: 1).animate(controller))
        .toList();
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _flipCard(int index) {
    if (_isFrontList[index]) {
      _controllers[index].forward();
    } else {
      _controllers[index].reverse();
    }
    setState(() {
      _isFrontList[index] = !_isFrontList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lstFlashCard.isEmpty) {
      return BasePage(
        showLeading: true,
        title: 'flashcard'.tr(),
        body: Center(child: Text('empty'.tr())),
      );
    }
    return BasePage(
      showLeading: true,
      title: 'flashcard'.tr(),
      body: Stack(
        children: [
          CardSwiper(
            cardsCount: widget.lstFlashCard.length,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
              return GestureDetector(
                // onTap: () => _flipCard(index),
                child: _buildLargeCard(
                  widget.lstFlashCard[index].english!,
                  widget.lstFlashCard[index].vietnam!,
                  index,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Hàm xây dựng thẻ phóng to với hiệu ứng lật
  Widget _buildLargeCard(String text, String language, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _flipCard(index),
        child: AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            final angle = _animations[index].value * pi;
            bool isFrontVisible = _animations[index].value < 0.5;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isFrontVisible
                  ? _buildCard(text, AppColor.blue)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildCard(language, AppColor.green),
                    ),
            );
          },
        ),
      ),
    );
  }

  // Hàm xây dựng nội dung thẻ
  Widget _buildCard(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: color, // Màu thẻ
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColor.extraColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart'; // Thư viện carousel

import 'package:quizlet_xspin/constants/app_color.dart'; // Thư viện màu sắc của bạn

class FlipCardCarousel extends StatefulWidget {
  const FlipCardCarousel({super.key});

  @override
  State<FlipCardCarousel> createState() => _FlipCardCarouselState();
}

class _FlipCardCarouselState extends State<FlipCardCarousel>
    with TickerProviderStateMixin {
  late List<bool> _isFrontList;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  int _currentIndex = 0; // Biến để lưu vị trí hiện tại của slide

  final List<Map<String, String>> _cardsContent = [
    {
      'front': 'Hello',
      'back': 'Xin chào',
      'frontLang': 'English',
      'backLang': 'Vietnamese'
    },
    {
      'front': 'Bye',
      'back': 'Tạm biệt',
      'frontLang': 'English',
      'backLang': 'Vietnamese'
    },
  ];

  @override
  void initState() {
    super.initState();
    _isFrontList = List<bool>.filled(_cardsContent.length, true);
    _controllers = List<AnimationController>.generate(
      _cardsContent.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );

    _animations = _controllers
        .map(
            (controller) => Tween<double>(begin: 0, end: 1).animate(controller))
        .toList();
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
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _cardsContent.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () => _flipCard(index),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    final angle = _animations[index].value * pi;
                    bool isFrontVisible = _animations[index].value < 0.5;

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Hiệu ứng 3D
                        ..rotateY(angle),
                      child: isFrontVisible
                          ? _buildCard(_cardsContent[index]['front']!,
                              _cardsContent[index]['frontLang']!, Colors.blue)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(pi),
                              child: _buildCard(
                                  _cardsContent[index]['back']!,
                                  _cardsContent[index]['backLang']!,
                                  Colors.green),
                            ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 250, // Chiều cao của carousel
            enlargeCenterPage: true, // Phóng to thẻ ở giữa
            autoPlay: false, // Tắt tự động chuyển slide
            viewportFraction: 1, // Kích thước viewport của mỗi thẻ
            enableInfiniteScroll:
                false, // Tắt cuộn vô hạn, chỉ vuốt được đến slide cuối cùng
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Cập nhật vị trí slide hiện tại
              });
            },
          ),
        ),
        // Phần hiển thị các dots dưới slide
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _cardsContent.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCard(String text, String language, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        key: ValueKey(language),
        color: color,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: AppColor.extraColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

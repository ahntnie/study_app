import 'package:flutter/material.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart'; // Thư viện carousel

import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/student/widget/full.flipcard.widget.dart';
import 'package:stacked/stacked.dart'; // Thư viện màu sắc của bạn

class FlipCardCarousel extends StatefulWidget {
  const FlipCardCarousel(
      {super.key, required this.idListCard, required this.viewModel});
  final String idListCard;
  final ListFlashCardViewModel viewModel;
  @override
  State<FlipCardCarousel> createState() => _FlipCardCarouselState();
}

class _FlipCardCarouselState extends State<FlipCardCarousel>
    with TickerProviderStateMixin {
  late List<bool> _isFrontList;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _isFrontList =
        List<bool>.filled(widget.viewModel.lstFlashCard.length, true);
    _controllers = List<AnimationController>.generate(
      widget.viewModel.lstFlashCard.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );

    _animations = _controllers
        .map(
            (controller) => Tween<double>(begin: 0, end: 1).animate(controller))
        .toList();
    // widget.viewModel.getFlashCard(widget.idListCard);
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
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.viewModel,
        onViewModelReady: (viewModel) async {},
        builder: (context, viewModel, child) {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: widget.viewModel.lstFlashCard.length,
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
                                ? _buildCard(
                                    viewModel.lstFlashCard[index].english!,
                                    viewModel.lstFlashCard[index].english!,
                                    Colors.blue,
                                    index)
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()..rotateY(pi),
                                    child: _buildCard(
                                        viewModel.lstFlashCard[index].vietnam!,
                                        viewModel.lstFlashCard[index].vietnam!,
                                        Colors.green,
                                        index),
                                  ),
                          );
                        },
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: viewModel.lstFlashCard
                    .take(10)
                    .toList()
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    onTap: () => setState(() => _currentIndex = entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                                _currentIndex == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        });
  }

  Widget _buildCard(String text, String language, Color color, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        key: ValueKey(language),
        color: color,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Thẻ chính
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(fontSize: 24, color: AppColor.extraColor),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  Icons.zoom_out_map_rounded,
                  color: AppColor.extraColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenFlashcardsPage(
                        lstFlashCard: widget.viewModel
                            .lstFlashCard, // Pass the list to the next page
                        initialIndex: index,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

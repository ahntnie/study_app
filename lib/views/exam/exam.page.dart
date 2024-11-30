import 'package:flutter/material.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';

class ExamPage extends StatefulWidget {
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int _currentQuestionIndex = 0;
  final int _totalQuestions = 10;
  int _correctAnswer = 1;
  int? _selectedAnswer; // Biến lưu đáp án đã chọn

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showMore: true,
      title: 'Bài học',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Định nghĩa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Làm sao mà biết được.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),

          // Các tùy chọn trả lời
          Expanded(
            child: ListView(
              children: [
                _buildOption(1, 'I was just daydreaming.'),
                _buildOption(2, 'There\'s no way to know'),
                _buildOption(3, 'You better believe it!'),
                _buildOption(4, 'What\'s on your mind?'),
              ],
            ),
          ),

          // Nút trợ giúp
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Xử lý khi người dùng bấm vào nút "Bạn không biết?"
              },
              child: Text('Bạn không biết?'),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm để xây dựng một tùy chọn trả lời
  Widget _buildOption(int number, String text) {
    // Màu viền thay đổi theo kết quả câu trả lời
    Color _getBorderColorForOption(int option) {
      if (_selectedAnswer == null) {
        return Colors.grey.shade300; // Chưa chọn đáp án
      } else if (option == _correctAnswer) {
        return Colors.green; // Đáp án đúng có viền xanh
      } else if (option == _selectedAnswer && option != _correctAnswer) {
        return Colors.red; // Đáp án sai có viền đỏ
      } else {
        return Colors.grey.shade300; // Các đáp án còn lại giữ nguyên
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.extraColor, // Nền giữ nguyên màu trắng
          foregroundColor: Colors.black, // Màu chữ giữ nguyên
          side: BorderSide(
            color: _getBorderColorForOption(number), // Màu viền thay đổi
            width: 2, // Độ dày viền
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          // Kiểm tra nếu đã chọn đáp án thì không làm gì
          if (_selectedAnswer == null) {
            setState(() {
              _selectedAnswer = number; // Lưu câu trả lời đã chọn
            });
          }
        },
        child: Row(
          children: [
            Text(
              number.toString(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

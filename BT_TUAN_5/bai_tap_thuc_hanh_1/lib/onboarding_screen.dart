// file: onboarding_screen.dart
import 'package:flutter/material.dart';
import 'Models/onboarding_content.dart'; // Đảm bảo đường dẫn này đúng với máy bạn
import 'dart:ui';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Phần Header: Dots indicator và nút Skip
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dots indicator
                  Row(
                    children: List.generate(
                      contents.length,
                      (index) => buildDot(index, context),
                    ),
                  ),

                  // SỬA LỖI LAYOUT BỊ NHẢY: Dùng Visibility thay vì if
                  Visibility(
                    visible:
                        currentIndex !=
                        contents.length -
                            1, // Chỉ hiện khi không phải trang cuối
                    maintainSize: true, // Giữ nguyên kích thước khi ẩn
                    maintainAnimation: true, // Giữ nguyên hiệu ứng
                    maintainState: true, // Giữ nguyên trạng thái
                    child: TextButton(
                      onPressed: () {
                        _controller.jumpToPage(contents.length - 1);
                      },
                      child: const Text(
                        "skip",
                        style: TextStyle(
                          color: Color(0xFF006EE9),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Phần PageView: Nội dung trượt
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(contents[i].image, height: 250),
                        const SizedBox(height: 40),

                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          contents[i].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 39, 39, 39),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 3. Phần Footer: Các nút điều hướng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  // Nút Back
                  if (currentIndex > 0)
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2196F3),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ),

                  // Nút Next hoặc Get Started
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex == contents.length - 1) {
                          // SỬA LỖI ĐIỀU HƯỚNG: Quay về trang đầu tiên
                          _controller.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        currentIndex == contents.length - 1
                            ? "Get Started"
                            : "Next",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10, // Kích thước cố định
      width: 10, // Kích thước cố định (hình tròn)
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index
            ? const Color(0xFF006EE9)
            : const Color(0xFFD8D8D8),
      ),
    );
  }
}

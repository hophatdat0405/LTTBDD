// file: verify_code_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import để dùng FilteringTextInputFormatter
import 'create_new_password_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  // Tạo 5 controller riêng cho 5 ô nhập
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  // Tạo 5 FocusNode để điều khiển chuyển ô
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi tắt màn hình
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Hàm ghép 5 ô lại thành 1 chuỗi code
  String getCode() {
    return _controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2196F3),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- HEADER (Đã xóa chữ đỏ) ---
            Image.asset('assets/images/uth_logo.png', width: 100),
            const SizedBox(height: 15),
            const Text(
              "SmartTasks",
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // ------------------------------
            const SizedBox(height: 40),

            const Text(
              "Verify Code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              "Enter the code\nwe just sent you on your registered Email",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 40),

            // --- 5 Ô NHẬP CODE RIÊNG BIỆT ---
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Căn đều khoảng cách
              children: List.generate(5, (index) {
                return SizedBox(
                  width: 55, // Độ rộng mỗi ô
                  height: 55, // Độ cao mỗi ô
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1, // Chỉ cho nhập 1 ký tự
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ], // Chỉ nhận số
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      counterText: "", // Ẩn bộ đếm số ký tự bên dưới
                      filled: true,
                      fillColor: const Color(0xFFF5F6FA), // Màu nền xám nhạt
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Bo góc vuông mềm
                        borderSide: BorderSide.none, // Không viền
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        // Nhập xong tự nhảy sang ô tiếp theo
                        if (index < 4) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_focusNodes[index + 1]);
                        } else {
                          // Ô cuối cùng thì ẩn bàn phím
                          FocusScope.of(context).unfocus();
                        }
                      } else if (value.isEmpty && index > 0) {
                        // Xóa thì lùi lại ô trước
                        FocusScope.of(
                          context,
                        ).requestFocus(_focusNodes[index - 1]);
                      }
                    },
                  ),
                );
              }),
            ),

            // -------------------------------
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Lấy code từ 5 ô ghép lại
                  String fullCode = getCode();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewPasswordScreen(
                        email: widget.email,
                        code: fullCode, // Truyền chuỗi code đầy đủ
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

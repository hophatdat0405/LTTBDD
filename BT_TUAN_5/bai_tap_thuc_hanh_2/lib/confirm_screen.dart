// file: confirm_screen.dart
import 'package:flutter/material.dart';

class ConfirmScreen extends StatefulWidget {
  final String email;
  final String code;
  final String password;

  const ConfirmScreen({
    super.key,
    required this.email,
    required this.code,
    required this.password,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  // Biến trạng thái để kiểm soát việc hiện mật khẩu
  bool _showPassword = false;

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
            // --- HEADER ---
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

            // --------------
            const SizedBox(height: 40),

            const Text(
              "Confirm",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "We are here to help you!",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 40),

            // Email (Hiện bình thường)
            buildReadOnlyField(
              Icons.person_outline,
              widget.email,
              isPassword: false,
            ),

            const SizedBox(height: 15),

            // Code (Hiện bình thường)
            buildReadOnlyField(
              Icons.check_circle_outline,
              widget.code,
              isPassword: false,
            ),

            const SizedBox(height: 15),

            // Password (Có tính năng ẩn/hiện)
            // Truyền password thực vào, việc che dấu sẽ do hàm xử lý
            buildReadOnlyField(
              Icons.lock_outline,
              widget.password,
              isPassword: true,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password Reset Successfully!"),
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
                  "Submit",
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

  // Widget tạo ô hiển thị thông tin
  // Thêm tham số isPassword để xử lý riêng cho ô mật khẩu
  Widget buildReadOnlyField(
    IconData icon,
    String text, {
    required bool isPassword,
  }) {
    return TextField(
      readOnly: true, // Không cho sửa
      enabled:
          true, // Bật true để nút bấm icon vẫn nhận được sự kiện (nhưng vẫn readOnly)
      // Nếu là password thì dùng biến _showPassword để quyết định che hay không
      // Nếu không phải password (email, code) thì luôn hiện (obscureText = false)
      obscureText: isPassword ? !_showPassword : false,

      controller: TextEditingController(text: text),
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),

        // Chỉ hiện nút con mắt nếu đây là ô Password
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              )
            : null,

        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        // Chỉnh lại màu icon/text khi focus để trông vẫn như đang read-only
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}

// file: create_new_password_screen.dart
import 'package:flutter/material.dart';
import 'confirm_screen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const CreateNewPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  // --- 1. THÊM BIẾN TRẠNG THÁI ĐỂ QUẢN LÝ VIỆC HIỆN MẬT KHẨU ---
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  // -----------------------------------------------------------

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
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

            // -----------------------------------------------------
            const SizedBox(height: 40),

            const Text(
              "Create new password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your new password must be different from\npreviously used password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 40),

            // --- Ô NHẬP PASSWORD 1 (ĐÃ SỬA) ---
            TextField(
              controller: _passController,
              // 2. obscureText dựa vào biến trạng thái (nếu _showPassword là true thì không che)
              obscureText: !_showPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),

                // 3. Thêm nút icon con mắt ở cuối
                suffixIcon: IconButton(
                  icon: Icon(
                    // Chọn icon dựa trên trạng thái hiện tại
                    _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Khi nhấn nút, đảo ngược trạng thái và vẽ lại widget
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),

                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // --- Ô NHẬP CONFIRM PASSWORD (ĐÃ SỬA TƯƠNG TỰ) ---
            TextField(
              controller: _confirmPassController,
              // Dựa vào biến trạng thái thứ 2
              obscureText: !_showConfirmPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                hintText: "Confirm Password",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),

                // Thêm nút icon con mắt cho ô xác nhận
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                ),

                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // (Tùy chọn) Thêm kiểm tra xem 2 mật khẩu có khớp nhau không trước khi đi tiếp
                  if (_passController.text != _confirmPassController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match!")),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmScreen(
                        email: widget.email,
                        code: widget.code,
                        password: _passController.text,
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

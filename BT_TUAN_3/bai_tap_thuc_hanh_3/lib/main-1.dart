import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: BaiThucHanh1()),
  );
}

class BaiThucHanh1 extends StatefulWidget {
  const BaiThucHanh1({super.key});

  @override
  State<BaiThucHanh1> createState() => _BaiThucHanh1State();
}

class _BaiThucHanh1State extends State<BaiThucHanh1> {
  String noiDungGiua = "Hello";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // --- Phần 1: TextView Tiêu đề ---
              const Text(
                "My First App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              // --- Phần 2: TextView Nội dung thay đổi ---
              Text(
                noiDungGiua, // Sử dụng biến đã khai báo
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54, // Màu xám nhẹ
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center, // Căn giữa chữ
              ),

              ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn nút
                  setState(() {
                    // Thay đổi giá trị của biến và cập nhật lại giao diện
                    noiDungGiua = "I'm Hồ Phát Ddạt";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], // Màu nền nút xanh đậm
                  foregroundColor: Colors.white, // Màu chữ trắng
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ), // Kích thước nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo tròn góc nút
                  ),
                ),
                child: const Text(
                  "Say Hi!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

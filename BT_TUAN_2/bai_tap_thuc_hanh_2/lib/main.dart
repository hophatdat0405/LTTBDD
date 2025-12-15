import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ThucHanh2Screen(),
    );
  }
}

class ThucHanh2Screen extends StatefulWidget {
  const ThucHanh2Screen({super.key});

  @override
  State<ThucHanh2Screen> createState() => _ThucHanh2ScreenState();
}

class _ThucHanh2ScreenState extends State<ThucHanh2Screen> {
  final TextEditingController _controller = TextEditingController();
  int _soLuong = 0;
  String? _errorText;

  void _handleTaoDanhSach() {
    setState(() {
      String textInput = _controller.text;
      int? parsedNumber = int.tryParse(textInput);

      if (parsedNumber == null || parsedNumber < 0) {
        _errorText = "Dữ liệu bạn nhập không hợp lệ";
        _soLuong = 0;
      } else {
        _errorText = null;
        _soLuong = parsedNumber;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ĐÃ XÓA PHẦN APPBAR Ở ĐÂY
      body: SafeArea(
        // Thêm SafeArea để nội dung không bị dính lên thanh trạng thái
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Thực hành 02",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Nhập vào số lượng",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _handleTaoDanhSach,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      "Tạo",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _soLuong,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

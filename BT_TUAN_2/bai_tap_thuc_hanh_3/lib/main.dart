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
      home: const ThucHanh3Screen(),
    );
  }
}

class ThucHanh3Screen extends StatefulWidget {
  const ThucHanh3Screen({super.key});

  @override
  State<ThucHanh3Screen> createState() => _ThucHanh3ScreenState();
}

class _ThucHanh3ScreenState extends State<ThucHanh3Screen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  double? _result;
  String _errorText = "";

  // 1. Thêm biến để lưu phép toán đang được chọn (VD: '+', '-', null)
  String? _selectedOperation;

  void _calculate(String operation) {
    setState(() {
      // Cập nhật phép toán đang chọn để highlight nút
      _selectedOperation = operation;

      if (_controller1.text.isEmpty || _controller2.text.isEmpty) {
        _errorText = "Vui lòng nhập đủ 2 số";
        _result = null;
        return;
      }

      double num1 = double.tryParse(_controller1.text) ?? 0;
      double num2 = double.tryParse(_controller2.text) ?? 0;

      switch (operation) {
        case '+':
          _result = num1 + num2;
          break;
        case '-':
          _result = num1 - num2;
          break;
        case '*':
          _result = num1 * num2;
          break;
        case '/':
          if (num2 == 0) {
            _errorText = "Không thể chia cho 0";
            _result = null;
            return;
          }
          _result = num1 / num2;
          break;
      }
      _errorText = "";
    });
  }

  Widget _buildButton(String label, Color color) {
    // 2. Kiểm tra xem nút này có đang được chọn không
    bool isSelected = _selectedOperation == label;

    return ElevatedButton(
      onPressed: () => _calculate(label),
      style: ElevatedButton.styleFrom(
        // Logic đổi màu: Nếu được chọn thì giữ màu gốc, nếu không thì mờ đi (hoặc xám)
        backgroundColor: isSelected ? color : color.withOpacity(0.3),

        // Thêm viền đen nếu được chọn để nổi bật hơn
        side: isSelected
            ? const BorderSide(color: Colors.black, width: 2)
            : null,

        elevation: isSelected ? 10 : 0, // Nút chọn sẽ nổi lên cao hơn
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          // Nếu không chọn thì chữ màu xám cho chìm xuống, chọn rồi thì màu trắng
          color: isSelected ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Thực hành 03",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _controller1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Nhập số thứ nhất",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.input),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _controller2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Nhập số thứ hai",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.input),
                ),
              ),
              const SizedBox(height: 20),

              if (_errorText.isNotEmpty)
                Center(
                  child: Text(
                    _errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton("+", Colors.red),
                  _buildButton("-", Colors.orange),
                  _buildButton("*", Colors.blue),
                  _buildButton(
                    "/",
                    Colors.black,
                  ), // Màu đen hơi đặc biệt, khi mờ sẽ thành xám
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Kết quả:",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Text(
                _result != null ? _result.toString() : "...",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

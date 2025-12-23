import 'package:flutter/material.dart';

// --- PHẦN 1: ÁP DỤNG OOP (Định nghĩa Class) ---

/// Class đại diện cho một phương thức thanh toán
class PaymentMethod {
  final String id;
  final String name;
  final String iconPath; // Đường dẫn icon nhỏ (hoặc dùng IconData để demo)
  final IconData demoIcon; // Dùng để demo code chạy ngay
  final Color themeColor; // Màu đặc trưng của hãng

  PaymentMethod({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.demoIcon,
    required this.themeColor,
  });
}

// Giả lập Database: Tạo danh sách các đối tượng thanh toán
final List<PaymentMethod> paymentMethods = [
  PaymentMethod(
    id: 'paypal',
    name: 'PayPal',
    iconPath: 'assets/paypal.png',
    demoIcon: Icons.paypal,
    themeColor: Colors.blue.shade900,
  ),
  PaymentMethod(
    id: 'google_pay',
    name: 'Google Pay',
    iconPath: 'assets/google.png',
    demoIcon: Icons.g_mobiledata, // Icon ví dụ
    themeColor: Colors.red,
  ),
  PaymentMethod(
    id: 'apple_pay',
    name: 'Apple Pay',
    iconPath: 'assets/apple.png',
    demoIcon: Icons.apple,
    themeColor: Colors.black,
  ),
];

// --- PHẦN 2: GIAO DIỆN (UI) ---

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Biến trạng thái lưu phương thức đang chọn
  // Dùng Nullable (?) vì ban đầu chưa chọn gì cả (tương ứng hình 1)
  PaymentMethod? _selectedMethod;

  // Hàm xử lý khi người dùng chọn một phương thức
  void _onMethodSelected(PaymentMethod method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Thanh toán", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chọn hình thức thanh toán",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // --- KHU VỰC HIỂN THỊ TRẠNG THÁI (OOP logic ở đây) ---
              // Expanded để đẩy danh sách xuống dưới và khu vực hiển thị chiếm chỗ trống
              Expanded(flex: 4, child: Center(child: _buildDisplayArea())),

              // --- DANH SÁCH LỰA CHỌN (Dùng OOP List để render) ---
              Expanded(
                flex: 6, // Chiếm phần lớn màn hình dưới
                child: Column(
                  children: [
                    // Dùng map để duyệt qua List objects -> List Widgets
                    ...paymentMethods.map(
                      (method) => _buildPaymentOption(method),
                    ),

                    const Spacer(),

                    // Nút Continue chỉ hiện/active khi đã chọn
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _selectedMethod == null
                            ? null // Disable nút nếu chưa chọn
                            : () {
                                // Xử lý tiếp theo
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Đã chọn: ${_selectedMethod!.name}",
                                    ),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor:
                              Colors.grey[300], // Màu khi disable
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị khu vực trung tâm (Thay đổi theo state)
  Widget _buildDisplayArea() {
    // TRƯỜNG HỢP 1: Chưa chọn gì (Null) -> Hiện icon ví mặc định
    if (_selectedMethod == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 10),
          const Text(
            "Vui lòng chọn phương thức",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
    }
    // TRƯỜNG HỢP 2: Đã chọn -> Hiện Logo to của object đó
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ở đây tôi dùng Icon thay cho Image.network để demo
          Icon(
            _selectedMethod!.demoIcon,
            size: 120,
            color: _selectedMethod!.themeColor,
          ),
          const SizedBox(height: 10),
          Text(
            _selectedMethod!.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _selectedMethod!.themeColor,
            ),
          ),
        ],
      );
    }
  }

  // Widget xây dựng từng dòng lựa chọn (Item)
  Widget _buildPaymentOption(PaymentMethod method) {
    final isSelected = _selectedMethod?.id == method.id;

    return GestureDetector(
      onTap: () => _onMethodSelected(method),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            // Radio Button custom logic
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 15),

            // Tên phương thức
            Text(
              method.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),

            const Spacer(),

            // Logo nhỏ bên phải (Mô phỏng bằng Icon)
            Icon(method.demoIcon, color: method.themeColor),
            // Nếu dùng ảnh thật: Image.asset(method.iconPath, width: 30),
          ],
        ),
      ),
    );
  }
}

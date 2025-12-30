import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Cấu hình chung cho App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Dùng giao diện hiện đại mới nhất
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- 1. MÀN HÌNH CHÀO (WELCOME SCREEN) ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Flutter giả lập logo trong hình
              const FlutterLogo(size: 100),
              const SizedBox(height: 30),
              const Text(
                "Flutter UI Basics",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Bài tập tổng hợp các UI Components cơ bản\ntrong Flutter tương tự Jetpack Compose.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              // Nút I'm Ready
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Điều hướng sang màn hình danh sách
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComponentListScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("I'm Ready"),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. MÀN HÌNH DANH SÁCH (MENU LIST) ---
class ComponentListScreen extends StatelessWidget {
  const ComponentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UI Components List")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader("Display (Hiển thị)"),
          _buildMenuItem(
            context,
            "Text",
            "Hiển thị văn bản đa dạng",
            const TextDetailScreen(),
          ),
          _buildMenuItem(
            context,
            "Image",
            "Hiển thị hình ảnh từ mạng",
            const ImageDetailScreen(),
          ),

          _buildHeader("Input (Nhập liệu)"),
          _buildMenuItem(
            context,
            "TextField",
            "Ô nhập liệu văn bản & mật khẩu",
            const InputDetailScreen(),
          ),
          _buildMenuItem(
            context,
            "Buttons",
            "Các loại nút bấm",
            const ButtonDetailScreen(),
          ),

          _buildHeader("Layout (Bố cục)"),
          _buildMenuItem(
            context,
            "Column & Row",
            "Sắp xếp dọc và ngang",
            const LayoutDetailScreen(),
          ),
          _buildMenuItem(
            context,
            "Stack (Box)",
            "Xếp chồng (tương tự Box)",
            const StackDetailScreen(),
          ),
          // Thêm dòng này vào danh sách menu trong ComponentListScreen
          _buildMenuItem(
            context,
            "More Basics",
            "Slider, Icon, Dialog, Container...",
            const MoreWidgetsScreen(),
          ),
        ],
      ),
    );
  }

  // Widget tiêu đề nhóm
  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  // Widget từng mục menu
  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String subtitle,
    Widget screen,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.widgets, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}

// --- 3. CÁC MÀN HÌNH CHI TIẾT (DETAILS) ---

// === 3.1 Text Detail (Giống hình Text Detail) ===
class TextDetailScreen extends StatelessWidget {
  const TextDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Detail")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sử dụng RichText để làm chữ có nhiều màu như trong hình mẫu
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  children: <TextSpan>[
                    // 1. Chữ "The " (Bình thường)
                    TextSpan(text: 'The '),

                    // 2. Chữ "quick " (Có gạch ngang ở giữa)
                    TextSpan(
                      text: 'quick ',
                      style: TextStyle(
                        decoration: TextDecoration
                            .lineThrough, // <--- Dòng này tạo gạch ngang
                      ),
                    ),
                    TextSpan(
                      text: 'Brown',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Chữ Brown màu cam
                    TextSpan(text: '\nfox j u m p s '), // \n để xuống dòng
                    TextSpan(
                      text: 'over',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ), // over đậm nghiêng
                    TextSpan(text: '\nthe '),
                    TextSpan(
                      text: 'lazy dog.',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ), // lazy dog gạch chân
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === 3.2 Image Detail ===
class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Images")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Ảnh từ Internet (NetworkImage):"),
          const SizedBox(height: 10),
          // Ảnh bo góc
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://tse2.mm.bing.net/th/id/OIP.j67p4fYQTMRFTrl5E-MbAQHaEK?pid=Api&P=0&h=180', // Link ảnh mẫu ngẫu nhiên
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text("Ảnh trong khung tròn (Avatar):"),
          const SizedBox(height: 10),
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/originals/eb/d5/60/ebd560e227514f9ef0245c9b2bdb3425.jpg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// === 3.3 Input Detail (TextField) ===
class InputDetailScreen extends StatefulWidget {
  const InputDetailScreen({super.key});

  @override
  State<InputDetailScreen> createState() => _InputDetailScreenState();
}

class _InputDetailScreenState extends State<InputDetailScreen> {
  // Biến để lưu text người dùng nhập
  String _inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextField")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField thường
            TextField(
              decoration: const InputDecoration(
                labelText: "Thông tin nhập",
                hintText: "Nhập tên của bạn...",
                border: OutlineInputBorder(), // Viền bao quanh
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (text) {
                setState(() {
                  _inputText = text;
                });
              },
            ),
            const SizedBox(height: 20),

            // TextField mật khẩu
            const TextField(
              obscureText: true, // Che dấu ký tự
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 30),
            // Hiển thị lại dữ liệu đã nhập (Giống dòng chữ đỏ trong hình)
            Text(
              "Dữ liệu bạn đang nhập: $_inputText",
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// === 3.4 Button Detail (Các loại nút & Lựa chọn) ===
class ButtonDetailScreen extends StatefulWidget {
  const ButtonDetailScreen({super.key});

  @override
  State<ButtonDetailScreen> createState() => _ButtonDetailScreenState();
}

class _ButtonDetailScreenState extends State<ButtonDetailScreen> {
  // 1. Biến trạng thái cho Checkbox (Chọn nhiều)
  bool _isChecked = false;

  // 2. Biến trạng thái cho Switch (Bật/Tắt)
  bool _isSwitched = false;

  // 3. Biến trạng thái cho Radio Button (Chọn 1 trong nhiều)
  // Giả sử: 1 là Nam, 2 là Nữ
  int _radioGroupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buttons & Selection")),
      body: SingleChildScrollView(
        // Thêm cuộn để tránh bị che khi màn hình nhỏ
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- PHẦN 1: CÁC NÚT BẤM CƠ BẢN ---
            const Text(
              "--- Action Buttons ---",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Elevated Button"),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Outlined Button"),
            ),

            const Divider(height: 30, thickness: 2), // Đường kẻ phân cách
            // --- PHẦN 2: CHECKBOX (Chọn nhiều) ---
            const Text(
              "--- Checkbox (Chọn nhiều) ---",
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!;
                    });
                  },
                ),
                Text(
                  _isChecked ? "Đã chọn (Checked)" : "Chưa chọn (Unchecked)",
                ),
              ],
            ),

            const Divider(height: 30, thickness: 2),

            // --- PHẦN 3: SWITCH (Công tắc) ---
            const Text(
              "--- Switch (Bật/Tắt) ---",
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: _isSwitched,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSwitched = newValue;
                    });
                  },
                ),
                Text(_isSwitched ? "ON (Bật)" : "OFF (Tắt)"),
              ],
            ),

            const Divider(height: 30, thickness: 2),

            // --- PHẦN 4: RADIO BUTTON (Chọn 1) ---
            const Text(
              "--- Radio Button (Chọn 1) ---",
              style: TextStyle(color: Colors.grey),
            ),
            // Lựa chọn 1
            Row(
              children: [
                Radio(
                  value: 1, // Giá trị của nút này là 1
                  groupValue: _radioGroupValue, // So sánh với giá trị đang chọn
                  onChanged: (int? value) {
                    setState(() {
                      _radioGroupValue = value!;
                    });
                  },
                ),
                const Text("Option 1 (Ví dụ: Nam)"),
              ],
            ),
            // Lựa chọn 2
            Row(
              children: [
                Radio(
                  value: 2, // Giá trị của nút này là 2
                  groupValue: _radioGroupValue, // Chung groupValue với nút trên
                  onChanged: (int? value) {
                    setState(() {
                      _radioGroupValue = value!;
                    });
                  },
                ),
                const Text("Option 2 (Ví dụ: Nữ)"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// === 3.5 Layout Detail (Column & Row) ===
class LayoutDetailScreen extends StatelessWidget {
  const LayoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Row & Column Layout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "1. Row Layout (Hàng ngang):",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Row Layout mô phỏng hình mẫu
            SingleChildScrollView(
              // Cho phép cuộn ngang nếu quá dài
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBox(Colors.blue.shade100),
                  _buildBox(Colors.blue.shade300),
                  _buildBox(Colors.blue.shade500),
                  _buildBox(Colors.blue.shade700),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "2. Column Layout (Cột dọc):",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _buildBox(Colors.green.shade100),
                _buildBox(Colors.green.shade300),
                _buildBox(Colors.green.shade500),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo hộp màu nhanh cho đỡ lặp code
  Widget _buildBox(Color color) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// === 3.6 Stack Detail (Tương đương Box trong Compose) ===
class StackDetailScreen extends StatelessWidget {
  const StackDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stack (Xếp chồng)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Stack cho phép xếp các phần tử đè lên nhau"),
            const SizedBox(height: 20),

            // Ví dụ về Stack
            Stack(
              alignment: Alignment.center, // Canh giữa tất cả
              children: [
                // Lớp 1: Dưới cùng (Hộp đỏ to)
                Container(width: 200, height: 200, color: Colors.red),
                // Lớp 2: Ở giữa (Hộp vàng nhỏ hơn)
                Container(width: 150, height: 150, color: Colors.yellow),
                // Lớp 3: Trên cùng (Text hoặc Icon)
                const Text(
                  "Top Layer",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// === 3.7 More Basic Widgets (Slider, Container, Dialog, Icon...) ===
class MoreWidgetsScreen extends StatefulWidget {
  const MoreWidgetsScreen({super.key});

  @override
  State<MoreWidgetsScreen> createState() => _MoreWidgetsScreenState();
}

class _MoreWidgetsScreenState extends State<MoreWidgetsScreen> {
  // Biến giá trị cho Slider (từ 0 đến 100)
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("More Basic Widgets")),
      // Drawer (Menu trượt từ trái sang)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Menu Drawer",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () {
                Navigator.pop(context);
              }, // Đóng drawer
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. SLIDER (Thanh trượt) ---
            const Text(
              "1. Slider (Thanh trượt)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 10, // Chia làm 10 nấc
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            Text("Giá trị hiện tại: ${_currentSliderValue.toInt()}"),
            const Divider(height: 30),

            // --- 2. ICON (Biểu tượng) ---
            const Text(
              "2. Icons (Biểu tượng)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite, color: Colors.pink, size: 40),
                Icon(Icons.audiotrack, color: Colors.green, size: 40),
                Icon(Icons.beach_access, color: Colors.blue, size: 40),
              ],
            ),
            const Divider(height: 30),

            // --- 3. CONTAINER (Trang trí) ---
            const Text(
              "3. Container (Trang trí, Bo góc, Đổ bóng)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 200,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orange, // Màu nền
                  borderRadius: BorderRadius.circular(20), // Bo góc
                  boxShadow: [
                    // Đổ bóng
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.red, width: 3), // Viền
                ),
                child: const Text(
                  "I am a Container",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(height: 30),

            // --- 4. DIALOGS & SNACKBAR (Thông báo) ---
            const Text(
              "4. Feedback (Thông báo)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút mở SnackBar
                ElevatedButton(
                  onPressed: () {
                    // Hiển thị thông báo ở dưới đáy
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đây là SnackBar!')),
                    );
                  },
                  child: const Text("Show SnackBar"),
                ),
                // Nút mở Alert Dialog
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Thông báo"),
                          content: const Text(
                            "Đây là Alert Dialog. Bạn có đồng ý không?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Hủy"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Đồng ý"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Show Alert"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

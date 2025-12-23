import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model ví dụ
class Student {
  String name; // Non-nullable: Bắt buộc phải có tên
  String? email; // Nullable: Email có thể chưa cập nhật (có thể null)
  String? address; // Nullable

  Student({required this.name, this.email, this.address});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NullableExampleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NullableExampleScreen extends StatefulWidget {
  const NullableExampleScreen({super.key});

  @override
  State<NullableExampleScreen> createState() => _NullableExampleScreenState();
}

class _NullableExampleScreenState extends State<NullableExampleScreen> {
  // 1. Khai báo biến Nullable (?)
  // Biến này có thể null nếu chưa load được dữ liệu sinh viên
  Student? currentStudent;

  @override
  void initState() {
    super.initState();
    // Giả lập việc chưa có dữ liệu ban đầu (currentStudent = null)
  }

  void loadData() {
    setState(() {
      // Gán dữ liệu (Email để null để test)
      currentStudent = Student(
        name: "Nguyễn Văn A",
        address: "TP. Hồ Chí Minh",
      );
    });
  }

  void clearData() {
    setState(() {
      currentStudent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bài tập Nullable - Flutter")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin sinh viên:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // --- VÍ DỤ VỀ CÁC TOÁN TỬ ---

            // 2. Toán tử Safe Call (?.)
            // Nếu currentStudent là null, nó sẽ không crash mà trả về null,
            // Text widget không nhận null nên ta phải xử lý tiếp.
            Text(
              "Tên: ${currentStudent?.name}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // 3. Toán tử Null-coalescing (??) - Tương ứng với ?: trong slide
            // Nếu email là null, nó sẽ hiển thị chuỗi bên phải "Chưa cập nhật"
            Text(
              "Email: ${currentStudent?.email ?? "Chưa cập nhật email"}",
              style: TextStyle(
                fontSize: 16,
                color: currentStudent?.email == null
                    ? Colors.red
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Kết hợp ?. và ??
            Text(
              "Địa chỉ: ${currentStudent?.address ?? "Chưa có địa chỉ"}",
              style: const TextStyle(fontSize: 16),
            ),

            const Divider(height: 40),

            if (currentStudent != null)
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.green[100],
                child: Text(
                  "Dữ liệu thô (Dùng !): ${currentStudent!.name.toUpperCase()}",
                  // Dấu ! ở đây khẳng định với Dart rằng currentStudent chắc chắn có dữ liệu
                ),
              ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: loadData,
                  child: const Text("Nạp dữ liệu"),
                ),
                ElevatedButton(
                  onPressed: clearData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                  ),
                  child: const Text("Xóa (Về Null)"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

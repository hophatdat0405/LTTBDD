import 'dart:ui';
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
      title: 'Demo LTTBDĐ',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),

      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const PresentationController(),
    );
  }
}

// ==========================================================================
// 1. BỘ ĐIỀU KHIỂN (CONTROLLER) - QUẢN LÝ MENU VÀ CHUYỂN CẢNH
// ==========================================================================
class PresentationController extends StatefulWidget {
  const PresentationController({super.key});

  @override
  State<PresentationController> createState() => _PresentationControllerState();
}

class _PresentationControllerState extends State<PresentationController> {
  int _currentIndex = 0;

  final List<String> _titles = [
    "1. Lỗi Column (Tràn màn hình)",
    "2. ListView Thường (Tốn RAM)",
    "3. ListView.builder (Tối ưu)",
    "4. Nested List (Kiểu Netflix)",
  ];

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const DemoOption1_ColumnError();
      case 1:
        return const DemoOption2_ListViewBasic();
      case 2:
        return const DemoOption3_ListViewBuilder();
      case 3:
        return const DemoOption4_NestedList();
      default:
        return const Center(child: Text("Chưa chọn demo"));
    }
  }

  void _updateDemo(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              accountName: Text(
                "Demo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              accountEmail: Text("Thuyết trình E-Learning"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.slideshow, size: 30, color: Colors.indigo),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    0,
                    "1. Lỗi Column",
                    Icons.error_outline,
                    Colors.red,
                  ),
                  _buildMenuItem(
                    1,
                    "2. ListView Cơ bản",
                    Icons.list_alt,
                    Colors.orange,
                  ),
                  const Divider(),
                  _buildMenuItem(
                    2,
                    "3. ListView.builder",
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildMenuItem(
                    3,
                    "4. Nested List (Netflix)",
                    Icons.dashboard_customize,
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _getScreen(_currentIndex),
    );
  }

  Widget _buildMenuItem(int index, String title, IconData icon, Color color) {
    bool isSelected = _currentIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? color : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? color : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      tileColor: isSelected ? color.withOpacity(0.1) : null,
      onTap: () => _updateDemo(index),
    );
  }
}

// --- DEMO 1: Lỗi Column ---
class DemoOption1_ColumnError extends StatelessWidget {
  const DemoOption1_ColumnError({super.key});

  @override
  Widget build(BuildContext context) {
    final list = List.generate(
      20,
      (i) => Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        color: Colors.red[100],
        alignment: Alignment.center,
        child: Text(
          "Item $i (Gây lỗi Overflow)",
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: list),
    );
  }
}

// --- DEMO 2: ListView Thường ---
class DemoOption2_ListViewBasic extends StatelessWidget {
  const DemoOption2_ListViewBasic({super.key});

  @override
  Widget build(BuildContext context) {
    final list = List.generate(100, (i) {
      print(" ListView Thường: Đang vẽ Item $i (Tốn RAM)");
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.orange[50],
        child: ListTile(
          leading: const Icon(Icons.warning_amber, color: Colors.orange),
          title: Text("Item #$i"),
          subtitle: const Text("Đã bị vẽ dù chưa nhìn thấy!"),
        ),
      );
    });

    return ListView(children: list);
  }
}

// --- DEMO 3: ListView.builder ---
class DemoOption3_ListViewBuilder extends StatelessWidget {
  const DemoOption3_ListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 10000,
        itemBuilder: (context, index) {
          print(" Builder: Đang vẽ Item $index (Tiết kiệm RAM)");
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text("Dữ liệu lớn $index"),
              subtitle: const Text("Chỉ tải khi cuộn tới đây."),
            ),
          );
        },
      ),
    );
  }
}

// --- DEMO 4: Nested List ---
class DemoOption4_NestedList extends StatelessWidget {
  const DemoOption4_NestedList({super.key});

  @override
  Widget build(BuildContext context) {
    // LIST CHA (DỌC)
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, indexCategory) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                "Danh mục Phim #$indexCategory",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),

            // 2. LIST CON (NGANG)
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, indexMovie) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue[(indexCategory * 100 + 100) % 900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Phim $indexMovie",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

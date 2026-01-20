import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';
import 'api_service.dart';
import 'detail_screen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    final tasks = await ApiService.fetchTasks();
    if (mounted) {
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    }
  }

  void _handleReturnFromDetail(dynamic result, int taskId) {
    if (result == true) {
      setState(() {
        _tasks.removeWhere((item) => item.id == taskId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Nếu đang tải -> Hiện màn hình Loading trắng
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_tasks.isEmpty) {
      return _buildEmptyScreen();
    }

    return _buildDataScreen();
  }

  // --- GIAO DIỆN KHI CÓ DỮ LIỆU ---
  Widget _buildDataScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        titleSpacing: 16,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LOGO UTH
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1).withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "UTH",
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "UNIVERSITY",
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Text(
                    "OF TRANSPORT",
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const Text(
                    "HOCHIMINH CITY",
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // APP NAME
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "SmartTasks",
                    style: TextStyle(
                      color: Color(0xFF42A5F5),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "A simple and efficient to-do app",
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4, right: 4),
                  child: Icon(
                    Icons.notifications,
                    color: Color(0xFFFFCA28),
                    size: 28,
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return _TaskCard(
            task: task,
            index: index,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(taskId: task.id),
                ),
              );
              _handleReturnFromDetail(result, task.id);
            },
          );
        },
      ),
      // Giữ Dashboard khi có dữ liệu
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.blue),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(
                  Icons.description_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- GIAO DIỆN KHI RỖNG (EMPTY STATE) ---
  Widget _buildEmptyScreen() {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "List",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: const _EmptyView(),
    );
  }
}

// --- WIDGET CARD (Giữ nguyên) ---
class _TaskCard extends StatelessWidget {
  final Task task;
  final int index;
  final VoidCallback onTap;

  const _TaskCard({
    required this.task,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    int styleIndex = index % 3;
    if (styleIndex == 0)
      bgColor = AppColors.cardRedBg;
    else if (styleIndex == 1)
      bgColor = AppColors.cardYellowBg;
    else
      bgColor = AppColors.cardBlueBg;

    String dateStr = "14:00 2500-03-26";
    if (task.dueDate != null) {
      dateStr = DateFormat('HH:mm yyyy-MM-dd').format(task.dueDate!);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.description.isEmpty
                            ? "No description"
                            : task.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    children: [
                      const TextSpan(text: "Status: "),
                      TextSpan(
                        text: task.status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET MÀN HÌNH RỖNG (VẼ TAY ĐỂ GIỐNG HÌNH NHẤT) ---
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // VẼ ICON CLIPBOARD ĐANG NGỦ
          SizedBox(
            width: 100,
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  top: 15,
                  left: 10,
                  right: 10,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black87, width: 2.5),
                    ),
                  ),
                ),

                Positioned(
                  top: 5,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black87, width: 2.5),
                    ),
                  ),
                ),
                // Móc treo nhỏ xíu
                Positioned(
                  top: 0,
                  left: 42,
                  right: 42,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black87, width: 2.5),
                    ),
                  ),
                ),

                // 3. Mắt đang ngủ (- -)
                Positioned(
                  top: 55,
                  left: 30,
                  child: Container(
                    width: 10,
                    height: 2.5,
                    color: Colors.black87,
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 30,
                  child: Container(
                    width: 10,
                    height: 2.5,
                    color: Colors.black87,
                  ),
                ),

                // 4. Miệng (Dấu gạch ngang nhỏ)
                Positioned(
                  top: 65,
                  left: 45,
                  right: 45,
                  child: Container(height: 2.5, color: Colors.black87),
                ),

                // 5. Chữ Zzz bay lên (Góc phải)
                const Positioned(
                  top: 15,
                  right: 0,
                  child: Text(
                    "Z",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Positioned(
                  top: 30,
                  right: -5,
                  child: Text(
                    "z",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            "No Tasks Yet!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Stay productive - add something to do",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

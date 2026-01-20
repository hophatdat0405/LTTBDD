import 'package:flutter/material.dart';
import 'models.dart';
import 'api_service.dart';

class DetailScreen extends StatefulWidget {
  final int taskId;
  const DetailScreen({super.key, required this.taskId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<TaskDetail> futureDetail;

  @override
  void initState() {
    super.initState();
    futureDetail = ApiService.fetchTaskDetail(widget.taskId);
  }

  void _deleteTask() async {
    try {
      bool success = await ApiService.deleteTask(widget.taskId);
      if (success && mounted) {
        Navigator.pop(context, true); // Trả về true để Home xóa item
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
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
          "Detail",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: InkWell(
                onTap: _deleteTask,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCCBC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<TaskDetail>(
        future: futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Not found"));
          }

          final detail = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.title.isNotEmpty ? detail.title : "No Title",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  detail.description.isNotEmpty
                      ? detail.description
                      : "No description",
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildInfoBox(
                      Icons.grid_view,
                      "Category",
                      detail.category,
                      Colors.pink[50]!,
                      Colors.pink,
                    ),
                    const SizedBox(width: 12),
                    _buildInfoBox(
                      Icons.sync_alt,
                      "Status",
                      detail.status,
                      Colors.grey[200]!,
                      Colors.black87,
                    ),
                    const SizedBox(width: 12),
                    _buildInfoBox(
                      Icons.flag_outlined,
                      "Priority",
                      detail.priority,
                      Colors.purple[50]!,
                      Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Subtasks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                if (detail.subtasks.isEmpty)
                  Column(
                    children: [
                      _buildSubTaskRow("Task A"),
                      _buildSubTaskRow("Task B"),
                    ],
                  )
                else
                  ...detail.subtasks.map((e) => _buildSubTaskRow(e.title)),
                const SizedBox(height: 24),
                const Text(
                  "Attachments",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(
                        detail.attachments.isNotEmpty
                            ? detail.attachments[0].fileName
                            : "doc.pdf",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox(
    IconData icon,
    String label,
    String value,
    Color bg,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTaskRow(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

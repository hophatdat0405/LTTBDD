import 'package:flutter/material.dart';

// 1. Tính Trừu tượng (Abstraction)
abstract class LibraryItem {
  String _id;
  String _title;
  bool _isBorrowed;

  LibraryItem(this._id, this._title, {bool isBorrowed = false})
    : _isBorrowed = isBorrowed;

  // Tính Đóng gói (Encapsulation): Getter
  String get id => _id;
  String get title => _title;
  bool get isBorrowed => _isBorrowed;

  // Phương thức trừu tượng
  String getDetails();

  // Logic nghiệp vụ đóng gói
  void toggleBorrowStatus() {
    _isBorrowed = !_isBorrowed;
  }
}

// 2. Tính Kế thừa (Inheritance)
class Book extends LibraryItem {
  String _author;

  Book(String id, String title, this._author, {bool isBorrowed = false})
    : super(id, title, isBorrowed: isBorrowed);

  String get author => _author;

  // 3. Tính Đa hình (Polymorphism)
  @override
  String getDetails() {
    return "Tác giả: $_author";
  }
}

class User {
  String id;
  String name;

  User({required this.id, required this.name});
}

// ==========================================
// PHẦN 2: ỨNG DỤNG FLUTTER (UI & LOGIC)
// ==========================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản lý thư viện',
      theme: ThemeData(
        fontFamily: 'Inter', // Hoặc 'Roboto'
        primarySwatch: Colors.blue,
        // Cài đặt font size mặc định theo yêu cầu (15.68px)
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 15.68),
          bodyLarge: TextStyle(fontSize: 15.68),
        ),
      ),
      home: const LibraryHomeScreen(),
    );
  }
}

class LibraryHomeScreen extends StatefulWidget {
  const LibraryHomeScreen({super.key});

  @override
  State<LibraryHomeScreen> createState() => _LibraryHomeScreenState();
}

class _LibraryHomeScreenState extends State<LibraryHomeScreen> {
  // --- STATE (DỮ LIỆU) ---
  int _currentIndex = 0; // Tab mặc định là Quản lý

  // Danh sách người dùng
  final List<User> userList = [
    User(id: "NV01", name: "Nguyen Van A"),
    User(id: "NV02", name: "Tran Thi B"),
    User(id: "NV03", name: "Le Van C"),
  ];

  late User currentUser;

  // Danh sách sách
  final List<LibraryItem> libraryItems = [
    Book("B01", "Lập trình Flutter", "Google Team"),
    Book("B02", "Đắc Nhân Tâm", "Dale Carnegie", isBorrowed: true),
    Book("B03", "Nhà Giả Kim", "Paulo Coelho"),
    Book("B04", "Clean Code", "Robert C. Martin"),
  ];

  @override
  void initState() {
    super.initState();
    currentUser = userList[0]; // Mặc định chọn người đầu tiên
  }

  // --- LOGIC ---

  // 1. Xử lý mượn/trả
  void _handleBorrow(int index) {
    setState(() {
      libraryItems[index].toggleBorrowStatus();
    });
    // Thông báo
    final item = libraryItems[index];
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${currentUser.name} đã ${item.isBorrowed ? 'mượn' : 'trả'}: ${item.title}",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // 2. Xử lý đổi người dùng (Hiện Dialog danh sách)
  void _showUserSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Chọn nhân viên làm việc"),
          children: userList.map((user) {
            return SimpleDialogOption(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: user.id == currentUser.id
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: user.id == currentUser.id
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: user.id == currentUser.id
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  currentUser = user;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  // 3. Xử lý thêm sách mới (Dialog)
  void _showAddBookDialog() {
    final titleController = TextEditingController();
    final authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thêm sách mới"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Tên sách",
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: "Tác giả",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    authorController.text.isNotEmpty) {
                  setState(() {
                    libraryItems.add(
                      Book(
                        "B${(libraryItems.length + 1).toString().padLeft(2, '0')}",
                        titleController.text,
                        authorController.text,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
              ),
              child: const Text("Lưu", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 4. Xử lý THÊM NHÂN VIÊN MỚI (MỚI)
  void _showAddUserDialog() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thêm nhân viên mới"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Họ tên nhân viên",
              hintText: "Nhập họ tên...",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_add),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    // Tự động sinh ID: NV04, NV05...
                    String newId =
                        "NV${(userList.length + 1).toString().padLeft(2, '0')}";
                    userList.add(User(id: newId, name: nameController.text));
                  });
                  Navigator.pop(context);
                  // Thông báo
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Đã thêm nhân viên: ${nameController.text}",
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
              ),
              child: const Text("Thêm", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách các màn hình tương ứng với Tabs
    final List<Widget> pages = [
      // Tab 1: Màn hình quản lý chính
      ManagementTab(
        user: currentUser,
        items: libraryItems,
        onToggleBorrow: _handleBorrow,
        onChangeUser: _showUserSelectionDialog,
        onAddBook: _showAddBookDialog,
      ),
      // Tab 2: Danh sách sách
      BookListTab(items: libraryItems),
      // Tab 3: Danh sách nhân viên (Truyền thêm hàm onAddUser)
      UserListTab(
        users: userList,
        currentUser: currentUser,
        onAddUser: _showAddUserDialog, // <--- Truyền hàm thêm nhân viên vào đây
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hệ thống Quản lý Thư viện",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue[800],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Quản lý"),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "DS Sách",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "DS NV"),
        ],
      ),
    );
  }
}

// ==========================================
// CÁC WIDGET CON (TÁCH UI)
// ==========================================

// --- TAB 1: GIAO DIỆN QUẢN LÝ (MAIN UI) ---
class ManagementTab extends StatelessWidget {
  final User user;
  final List<LibraryItem> items;
  final Function(int) onToggleBorrow;
  final VoidCallback onChangeUser;
  final VoidCallback onAddBook;

  const ManagementTab({
    super.key,
    required this.user,
    required this.items,
    required this.onToggleBorrow,
    required this.onChangeUser,
    required this.onAddBook,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần Nhân Viên
          const Text(
            "Nhân viên",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Text(user.name, style: const TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onChangeUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Đổi", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Phần Danh Sách Sách
          const Text(
            "Danh sách sách",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CheckboxListTile(
                    tileColor: item.isBorrowed
                        ? Colors.grey[100]
                        : Colors.white,
                    activeColor: Colors.blue[800],
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: item.isBorrowed
                            ? TextDecoration.lineThrough
                            : null,
                        color: item.isBorrowed ? Colors.grey : Colors.black87,
                      ),
                    ),
                    subtitle: Text(item.getDetails()),
                    value: item.isBorrowed,
                    onChanged: (val) => onToggleBorrow(index),
                    secondary: Icon(
                      Icons.book,
                      color: item.isBorrowed ? Colors.grey : Colors.blue,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // Nút Thêm Sách
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAddBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Thêm Sách",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- TAB 2: DANH SÁCH SÁCH CHI TIẾT ---
class BookListTab extends StatelessWidget {
  final List<LibraryItem> items;
  const BookListTab({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.isBorrowed ? Colors.grey[200] : Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.menu_book,
              color: item.isBorrowed ? Colors.grey : Colors.blue,
            ),
          ),
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("${item.getDetails()}\nMã: ${item.id}"),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item.isBorrowed ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: item.isBorrowed ? Colors.red : Colors.green,
              ),
            ),
            child: Text(
              item.isBorrowed ? "Đã mượn" : "Có sẵn",
              style: TextStyle(
                color: item.isBorrowed ? Colors.red : Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

// --- TAB 3: DANH SÁCH NGƯỜI DÙNG (CÓ CHỨC NĂNG THÊM) ---
class UserListTab extends StatelessWidget {
  final List<User> users;
  final User currentUser;
  final VoidCallback onAddUser; // Callback để thêm nhân viên

  const UserListTab({
    super.key,
    required this.users,
    required this.currentUser,
    required this.onAddUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Danh sách nhân viên",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final isSelected = user.id == currentUser.id;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: isSelected ? 2 : 0,
                  shape: RoundedRectangleBorder(
                    side: isSelected
                        ? const BorderSide(color: Colors.blue, width: 1.5)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: isSelected ? Colors.blue[50] : Colors.grey[100],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected ? Colors.blue : Colors.grey,
                      child: Text(
                        user.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("ID: ${user.id}"),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.blue)
                        : null,
                  ),
                );
              },
            ),
          ),

          // Nút Thêm Nhân Viên
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAddUser,
              icon: const Icon(Icons.person_add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green[700], // Màu xanh lá cho khác biệt xíu
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              label: const Text(
                "Thêm Nhân Viên",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

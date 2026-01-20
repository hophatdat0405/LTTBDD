class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? 'No Title',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      priority: json['priority']?.toString() ?? 'Low',
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'].toString())
          : null,
    );
  }
}

class TaskDetail {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String category;
  final List<SubTask> subtasks;
  final List<Attachment> attachments;

  TaskDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.subtasks,
    required this.attachments,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      priority: json['priority']?.toString() ?? 'Low',
      category: json['category']?.toString() ?? 'General',
      subtasks:
          (json['subtasks'] as List?)
              ?.map((e) => SubTask.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      attachments:
          (json['attachments'] as List?)
              ?.map((e) => Attachment.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
    );
  }
}

class SubTask {
  final String title;
  final bool isCompleted;

  SubTask({required this.title, required this.isCompleted});

  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      title: json['title']?.toString() ?? '',
      isCompleted: json['isCompleted'] == true,
    );
  }
}

class Attachment {
  final String fileName;

  Attachment({required this.fileName});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(fileName: json['fileName']?.toString() ?? '');
  }
}

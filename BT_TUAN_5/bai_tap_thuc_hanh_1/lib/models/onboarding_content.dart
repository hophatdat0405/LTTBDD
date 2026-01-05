// file: onboarding_content.dart

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  // Constructor
  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

// Danh sách dữ liệu (giả lập các trang trong hình)
List<OnboardingContent> contents = [
  OnboardingContent(
    image: 'assets/images/1.png', // Bạn cần thay hình của bạn vào đây
    title: 'Easy Time Management',
    description:
        'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first.',
  ),
  OnboardingContent(
    image: 'assets/images/2.png',
    title: 'Increase Work Effectiveness',
    description:
        'Time management and the determination of more important tasks will give your job statistics better and always improve.',
  ),
  OnboardingContent(
    image: 'assets/images/3.png',
    title: 'Reminder Notification',
    description:
        'The advantage of this application is that it also provides reminders for you so you don\'t forget to keep doing your assignments well.',
  ),
];

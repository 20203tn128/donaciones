class ValidationsApp {
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const password = '^(?=.*[a-z]).{5,}';
  // r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,}';
  static const phone = r'\d{10}';
}

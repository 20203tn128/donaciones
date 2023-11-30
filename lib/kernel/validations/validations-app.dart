class ValidationsApp {
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const password = '^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}';
  static const phone = '\d{10} Teléfono?';
  //^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$
}

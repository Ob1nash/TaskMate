class Todo {
  int id;
  String title;
  String description;
  bool isdone;
  String date;
  Function()? onPress;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isdone,
    required this.date,
    this.onPress, // Make it optional
  });
}

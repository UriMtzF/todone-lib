enum Status {
  done,
  undone,
}

class Task {
  Status status;
  DateTime? doneDate;
  String priority = "";
  DateTime? creationDate;
  Set<String> tags = {};
  DateTime? dueDate;
  String title;
  // Set<String>? attachments;
  // String? description;

  Task([this.title = "", this.status = Status.done]);
}

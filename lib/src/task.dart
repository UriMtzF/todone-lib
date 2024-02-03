/// Used in the [status] field of a [Task] object, is either done or undone.
enum Status {
  done,
  undone,
}

/// An object that has all the fields supported by the ToDone standard.
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

  Task([this.title = "", this.status = Status.undone]);
}

/// Used in the status field of a [Task] object, is either done or undone.
enum Status {
  done,
  undone,
}

/// An object that has all the fields supported by the ToDone standard.
class Task {
  Status status;
  String title;
  String? priority;
  DateTime? dueDate;
  DateTime? doneDate;
  DateTime? creationDate;
  Set<String>? tags;

  Task([this.title = "", this.status = Status.undone]);
}

/// An object that contains the task List and all the tags in them.
class Tasks {
  List<Task> tasksList;
  Set<String> tagsList = {};
  Tasks([List<Task>? tasksList]) : tasksList = tasksList ?? [];

  /// Checks all the tasks in the taksList field and fills the tagsList field.
  void setTagsList() {
    for (Task task in tasksList) {
      Set<String>? tags = task.tags;
      if (tags != null) {
        tagsList.addAll(tags);
      }
    }
  }
}

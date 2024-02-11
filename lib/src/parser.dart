import 'task.dart';

/// A parser that can write and read [Task] objects.
class ToDone {
  /// From a [List] of [Task]s will generate a correctly formated [String] compatible with the ToDone format.
  String stringFromTasks(List<Task> tasks) {
    String fileContent = '';
    for (Task task in tasks) {
      String line = '! ';
      if (task.status == Status.done) {
        if (task.doneDate == null) {
          line += 'done: ';
        } else {
          line += 'done:${task.doneDate.toString().substring(0, 10)} ';
        }
      }
      if (task.priority != null) {
        line += '(${task.priority}) ';
      }
      if (task.dueDate != null) {
        line += 'due:${task.dueDate.toString().substring(0, 10)} ';
      }
      line += '${task.title} ';
      if (task.creationDate != null) {
        line += 'created:${task.creationDate.toString().substring(0, 10)} ';
      }
      fileContent += '$line\n';
    }
    return fileContent;
  }

  /// Returns a [Tasks] object which contains the [List] of [Task]s.
  /// A [List] of [String] must be provided
  Tasks parseTasks(List<String> lines) {
    List<Task> tasksList = [];
    for (final line in lines) {
      if (line.startsWith('! ')) {
        Task task = Task();
        task.status = _parseStatus(line);
        task.doneDate = _parseDoneDate(line);
        task.priority = _parsePriority(line);
        task.creationDate = _parseCreationDate(line);
        task.tags = _parseTags(line);
        task.dueDate = _parseDueDate(line);
        task.title = _parseTitle(line, task);

        tasksList.add(task);
      }
    }

    Tasks tasks = Tasks();
    tasks.tasksList = tasksList;
    tasks.setTagsList();

    return tasks;
  }

  Status _parseStatus(String task) {
    RegExp exp = RegExp(' done:\\d{4}-\\d{2}-\\d{2}| done:');
    RegExpMatch? match = exp.firstMatch(task);
    return match == null ? Status.undone : Status.done;
  }

  DateTime? _parseDoneDate(String task) {
    RegExp exp = RegExp(' done:\\d{4}-\\d{2}-\\d{2}');
    RegExpMatch? match = exp.firstMatch(task);
    if (match != null) {
      DateTime? date = DateTime.tryParse(match[0].toString().substring(6));
      return date;
    }
    return null;
  }

  String _parsePriority(String task) {
    RegExp exp = RegExp(" \\([A-Z]\\) ");
    RegExpMatch? match = exp.firstMatch(task);
    if (match != null) {
      return match[0].toString().substring(2, 3);
    }
    return "";
  }

  DateTime? _parseCreationDate(String task) {
    RegExp exp = RegExp(" created:\\d{4}-\\d{2}-\\d{2}");
    RegExpMatch? match = exp.firstMatch(task);
    if (match != null) {
      DateTime? date = DateTime.tryParse(match[0].toString().substring(9));
      return date;
    }
    return null;
  }

  Set<String> _parseTags(String task) {
    RegExp exp = RegExp(" @(\\w+) ");
    Iterable<RegExpMatch> matches = exp.allMatches(task);
    Set<String> tags = {};
    if (matches.isNotEmpty) {
      for (var match in matches) {
        tags.add(match.toString());
      }
      return tags;
    }
    return {};
  }

  DateTime? _parseDueDate(String task) {
    RegExp exp = RegExp(" due:\\d{4}-\\d{2}-\\d{2}");
    RegExpMatch? match = exp.firstMatch(task);
    if (match != null) {
      DateTime? date = DateTime.tryParse(match[0].toString().substring(5));
      return date;
    }
    return null;
  }

  String _parseTitle(String taskText, Task task) {
    taskText = taskText.replaceAll("! ", "");
    if (task.doneDate != null) {
      taskText = taskText.replaceAll(
          "done:${task.doneDate.toString().substring(0, 10)}", "");
    }
    if (task.priority != null) {
      taskText = taskText.replaceAll(RegExp("\\([A-Z]\\)"), "");
    }
    if (task.creationDate != null) {
      taskText = taskText.replaceAll(
          "created:${task.creationDate.toString().substring(0, 10)}", "");
    }
    if (task.dueDate != null) {
      taskText = taskText.replaceAll(
          "due:${task.dueDate.toString().substring(0, 10)}", "");
    }
    taskText = taskText.replaceAll("\\s+", "");
    return taskText.trim();
  }
}

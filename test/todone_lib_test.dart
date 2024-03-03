import 'package:todone_lib/todone_lib.dart';
import 'package:test/test.dart';

void main() {
  late Tasks tasks;
  List<String> tasksAsLines = <String>[];
  ToDone parser = ToDone();

  tearDown(() => tasksAsLines = <String>[]);
  group('Can correctly parse tasks', () {
    setUp(() {
      tasksAsLines.add("! This is a valid task");
      tasksAsLines.add("? This is not a valid task");
      tasksAsLines.add("- This is not a valid task");
      tasks = parser.parseTasks(tasksAsLines);
    });
    test('Can parse all well written tasks', () {
      expect(tasks.tasksList.length, 1);
    });
  });

  group('Priority parser', () {
    setUp(() {
      tasksAsLines.add("! (A) This task has a priority");
      tasksAsLines.add("! This task has a valid priority (A) ");
      tasksAsLines.add("! (AB) This task does not have a valid priority");
      tasksAsLines.add("! (a) This task does not have a valid priority");
      tasksAsLines.add(
          "! This task has words in parentheses wihtout priority (This is not a priority)");
      tasksAsLines.add(
          "! (A) This task has words in parentheses and priority (This is not a priority)");

      tasks = parser.parseTasks(tasksAsLines);
    });
    test('Can parse priority at start', () {
      expect(tasks.tasksList[0].priority, "A");
    });
    test('Can parse priority anywhere on the line', () {
      expect(tasks.tasksList[1].priority, "A");
    });
    test('Does not parse wrong syntax', () {
      expect(tasks.tasksList[2].priority, null);
      expect(tasks.tasksList[3].priority, null);
    });
    test('Does not parse words in parentheses as priorities', () {
      expect(tasks.tasksList[4].priority, null);
      expect(tasks.tasksList[5].priority, "A");
    });
  });

  group('Status parser', () {
    setUp(() {
      tasksAsLines.add("! This task has a done status done:");
      tasksAsLines
          .add("! This task has a done status with date done:2024-03-01");
      tasksAsLines.add("! This task is marked as undone");
      tasksAsLines.add(
          "! This task won't be marked as done because the date is wrong done:01-03-24");
      tasks = parser.parseTasks(tasksAsLines);
    });
    test('Get status right', () {
      expect(tasks.tasksList[0].status, Status.done);
      expect(tasks.tasksList[1].status, Status.done);
      expect(tasks.tasksList[2].status, Status.undone);
      expect(tasks.tasksList[3].status, Status.done);
    });
    test('Get right date', () {
      expect(tasks.tasksList[1].doneDate, DateTime(2024, 3, 1));
      expect(tasks.tasksList[3].doneDate, null);
    });
  });

  group('Tags parser', () {
    setUp(() {
      tasksAsLines.add("! This task has one tag @tag1 ");
      tasksAsLines.add("! This task has two tags @tag1 @tag2 ");
      tasksAsLines.add("! This task has snake case tags @tag_1 @tag_2 ");
      tasksAsLines.add("! This task has one badly written tag @tag 1 ");
      tasks = parser.parseTasks(tasksAsLines);
    });
    test('Can parse one tag', () {
      expect(tasks.tasksList[0].tags, {"tag1"});
      expect(tasks.tasksList[3].tags, {"tag"});
    });
    test('Can parse multiple tags', () {
      expect(tasks.tasksList[1].tags, {"tag1", "tag2"});
      expect(tasks.tasksList[2].tags, {"tag_1", "tag_2"});
    });
  });

  group('Creation date parser', () {
    setUp(() {
      tasksAsLines
          .add("! This task has a valid creation date created:2024-03-01");
      tasksAsLines.add(
          "! This task has a wrongly written creation date (no creation date) created:01-03-24");
      tasks = parser.parseTasks(tasksAsLines);
    });
    test('Get only right typed creation date', () {
      expect(tasks.tasksList[0].creationDate, DateTime(2024, 3, 1));
      expect(tasks.tasksList[1].creationDate, null);
    });
  });

  group('Due date parser', () {
    setUp(() {
      tasksAsLines.add("! This task has a due date due:2024-03-01");
      tasksAsLines.add("! This task has no valid due date due:01-03-24");
      tasksAsLines
          .add("! This task has no due date even if it has a due keyword due:");
      tasks = parser.parseTasks(tasksAsLines);
    });
    test('Get only rigth typed due date', () {
      expect(tasks.tasksList[0].dueDate, DateTime(2024, 3, 1));
      expect(tasks.tasksList[1].dueDate, null);
      expect(tasks.tasksList[2].dueDate, null);
    });
  });

  group('Sorter', () {
    setUp(() {
      tasksAsLines.add("! D task");
      tasksAsLines.add("! (A) A task");
      tasksAsLines.add("! F tasks due:2024-02-01");
      tasksAsLines.add("! (B) B task");
      tasksAsLines.add("! C task");
      tasksAsLines.add("! (E) E task due:2024-01-01");
      tasks = parser.parseTasks(tasksAsLines);
    });

    test('Sort by alphabetical order', () {
      List<String> expectedTasksAsLines = [];
      expectedTasksAsLines.add("! (A) A task");
      expectedTasksAsLines.add("! (B) B task");
      expectedTasksAsLines.add("! C task");
      expectedTasksAsLines.add("! D task");
      expectedTasksAsLines.add("! (E) E task due:2024-01-01");
      expectedTasksAsLines.add("! F tasks due:2024-02-01");
      Tasks expectedTasks = parser.parseTasks(expectedTasksAsLines);
      tasks = parser.orderAlphabetical(tasks);

      for (int i = 0; i < tasks.tasksList.length; i++) {
        expect(tasks.tasksList[i].title, expectedTasks.tasksList[i].title);
      }
    });

    test('Sort by due date', () {
      List<String> expectedTasksAsLines = [];
      expectedTasksAsLines.add("! (E) E task due:2024-01-01");
      expectedTasksAsLines.add("! F tasks due:2024-02-01");
      expectedTasksAsLines.add("! D task");
      expectedTasksAsLines.add("! (A) A task");
      expectedTasksAsLines.add("! (B) B task");
      expectedTasksAsLines.add("! C task");
      Tasks expectedTasks = parser.parseTasks(expectedTasksAsLines);
      tasks = parser.orderDue(tasks);

      for (int i = 0; i < tasks.tasksList.length; i++) {
        expect(tasks.tasksList[i].title, expectedTasks.tasksList[i].title);
      }
    });

    test('Sort by priority', () {
      List<String> expectedTasksAsLines = [];
      expectedTasksAsLines.add("! (A) A task");
      expectedTasksAsLines.add("! (B) B task");
      expectedTasksAsLines.add("! (E) E task due:2024-01-01");
      expectedTasksAsLines.add("! D task");
      expectedTasksAsLines.add("! F tasks due:2024-02-01");
      expectedTasksAsLines.add("! C task");
      Tasks expectedTasks = parser.parseTasks(expectedTasksAsLines);
      tasks = parser.orderPriority(tasks);

      for (int i = 0; i < tasks.tasksList.length; i++) {
        expect(tasks.tasksList[i].title, expectedTasks.tasksList[i].title);
      }
    });
  });
}

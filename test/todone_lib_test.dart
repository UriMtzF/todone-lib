import 'dart:io';

import 'package:todone_lib/todone_lib.dart';
import 'package:test/test.dart';

void main() {
  final Parser parser = Parser();

  group('All ways of input working:', () {
    test('Works with String', () {
      List<Task> tasks = parser.parseTasksFromString('- Valid task');
      expect(tasks.isEmpty, false);
    });
    test('Works with file path', () {
      List<Task> tasks = parser.parseTasksFromPath('test/testTask.todo');
      expect(tasks.isEmpty, false);
    });
    test('Works with provided file', () {
      List<Task> tasks = parser.parseTasksFromFile(File('test/testTask.todo'));
      expect(tasks.isEmpty, false);
    });
  });

  group('Is valid task:', () {
    group('Only works with valid syntax:', () {
      test('Works with one task', () {
        String text = '- This is a valid task';
        List<Task> tasks = parser.parseTasksFromString(text);
        expect(tasks[0].title, 'This is a valid task');
      });
      test('Works with multiples tasks', () {
        String text = '- First task\n- Second task';
        List<Task> tasks = parser.parseTasksFromString(text);
        expect(tasks[0].title, 'First task');
        expect(tasks[1].title, 'Second task');
      });
    });
    group('Returns empty list with invalid syntax:', () {
      test('Works with one task', () {
        String text = 'This is not a task';
        List<Task> tasks = parser.parseTasksFromString(text);
        expect(tasks.isEmpty, true);
      });
      test('Works with multiple lines', () {
        String text =
            'This is not a valid task\n-This is not a valid task\n+This is not a valid task';
        List<Task> tasks = parser.parseTasksFromString(text);
        expect(tasks.isEmpty, true);
      });
    });
  });

  group('Can parse priority:', () {
    test('Right syntax', () {
      String text = '- (A) This has an A priority';
      List<Task> tasks = parser.parseTasksFromString(text);
      expect(tasks[0].priority, "A");
    });
    test('Only takes first coincidence', () {
      String text = '- (A) (B) This has an A priority';
      List<Task> tasks = parser.parseTasksFromString(text);
      expect(tasks[0].priority, "A");
    });
    test('Does not take lowercase', () {
      String text = '- (a) This is not a priority';
      List<Task> tasks = parser.parseTasksFromString(text);
      expect(tasks[0].priority, "");
    });
    test('Wrong syntax', () {
      String text = '- (A)This is not valid';
      List<Task> tasks = parser.parseTasksFromString(text);
      expect(tasks[0].priority, "");
    });
    test('Does not take other words in parentheses', () {
      String text =
          '- This has (a little secret)\n- (A) This also has (a secret)';
      List<Task> tasks = parser.parseTasksFromString(text);
      expect(tasks[0].priority, "");
      expect(tasks[1].priority, "A");
    });
  });
}

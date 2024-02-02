## Accesing tasks
You can access a particular task by iterating in any way the list.

The tasks object includes the following fields:
- `Status status`: The status is taken from an enum that is either `done` or `undone`
- `DateTime? doneDate`
- `String priority`: By default an empty String
- `DateTime? creationDate`
- `Set<String> tags`: By default and empty Set
- `DateTime? dueDate`
- `String title`: By default an empty String

## Creating a task
The library includes a constructor that creates a Task object.

By default, when creating a Task object with only a title it's created with the `undone` status.

```dart
Task example1 = Task();
Task example2 = Task('This is a title');
Task example3 = Task('This is a title', Status.done);
```
# Creating list of tasks
## Creating tasks from a file
Either if you want to take care of the file handling you can call the parser with a File objecto or just the path you should just use the parser and it will return a `List<Task>`.

```dart
// You can use either var or List<Task> to use the parser
List<Task> tasksFromFile = ToDone().parseFromFile(File('path/to/file'));
List<Task> tasksFromPath = ToDone().parseFromPath('path/to/file');
```
## Creating tasks from text
If you already have text in a String you can pass the String to the parser.

Be aware that the parser separate lines using the `\n` symbol, so any other form of _next line_ symbol won't work.

```dart
// You can use either var o List<Task> to use the parser
String text = '! This includes a task\n! This is a second task';
List<Task> tasksFromString = ToDone().parserFromString(text);
```
# Writing list of tasks
To write a List<Task> to a file you can provide a file path or a File object, either of those will open the file and if it doesn't exists it will create one.
```dart
ToDone().writeToFilePath('path/to/file', tasks);
ToDone().writeToFile(File('path/to/file'), tasks);
```
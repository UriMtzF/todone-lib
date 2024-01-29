A library made to parse Todone style tasks.
## Features 
This library can create a List of Task objects based on the ToDone standard [see more](#todone-standard).

It can create the List from:
- File object
- File path (String)
- String correctly formatted

## Usage examples
### Creating tasks from a file
Either if you want to take care of the file handling you can call the parser with a File objecto or just the path you should just use the parser and it will return a `List<Task>`.

```dart
// You can use either var or List<Task> to use the parser
List<Task> tasksFromFile = Parser().parseFromFile(File('path/to/file'));
List<Task> tasksFromPath = Parser().parseFromPath('path/to/file');
```
### Creating tasks from text
If you already have text in a String you can pass the String to the parser.

Be aware that the parser separate lines using the `\n` symbol, so any other form of _next line_ symbol won't work.

```dart
// You can use either var o List<Task> to use the parser
String text = '! This includes a task\n! This is a second task';
List<Task> tasksFromString = Parser().parserFromString(text);
```
### Accesing tasks
You can access a particular task by iterating in any way the list.

The tasks object includes the following fields:
- `Status status`: The status is taken from an enum that is either `done` or `undone`
- `DateTime? doneDate`
- `String priority`: By default an empty String
- `DateTime? creationDate`
- `Set<String> tags`: By default and empty Set
- `DateTime? dueDate`
- `String title`: By default an empty String

### Creating a task
The library includes a constructor that creates a Task object.

By default, when creating a Task object with only a title it's created with the `undone` status.

```dart
Task example1 = Task();
Task example2 = Task('This is a title');
Task example3 = Task('This is a title', Status.done);
```

## ToDone standard
The ToDone standard is heavily inspired by Todo.txt so this can be written in any kind of text file.

Any text that start with a `!` in a new line followed by a space and text is considered to be a task, this allows to write any kind of text without interfering with the parsing.

This standard allows to include:

- Creation date written as `created:YYYY-MM-DD` anywhere in the line
- Due date written as `due:YYYY-MM-DD` anywhere in the line
- Status, if no `done:` keyword is included it's considered as undone
- Done date written as `done:YYYY-MM-DD` anywhere in the linea
- Priority writen as `(A)`, the letter must be capital from A to Z anywhere in the line
- Tags written as `@Tag`, the tag can be anything wihtout spaces and can include any number of tags
- Title, is created from the rest of the text removing every other keyword and value except tags to keep any task logical while reading
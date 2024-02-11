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
## 0.0.1

- Initial version.
- Parser can read from a String right formatted, a path of a file or a File object.

## 0.0.2
- Fixed the standard to only include text that starts with `! `.
- Fixed an error that made the tasks to be set as `undone` when it included a `done:` keyword.

## 0.1.0
- Tests: Fixed the tests to be compatible with new standard.
- Library: Renamed class from Parser to ToDone.
- Library: Added method to write to file.
- Docs: Documented all public APIs.
- Docs: Moved examples from README to example/README.md.
- Docs: Reorganized examples and fixed to reflect the changes of the API.

## 0.1.1
- Library: Fixed the Task constructor to create a undone task by default.
- Library: Fixed a bug where it would write tasks in one line.

## 0.1.2
- Library: Fixed the parser from reading wrong tasks with a done date, created date and a due date.
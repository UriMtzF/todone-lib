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

## 1.0.0
- First stable release
- Library: Rewritten some parts of the library at it should do only the parsing and not the reading/writing operations (KISS principle).
- Library: Deleted all old methods.
- Tests: Deleted all tests.
- Documentation: Deleted old examples.

## 1.0.1
- Library: dart:io is no longer needed so the library can be used in web.

## 1.1.0
- Library: Fixed error on parsing tags, now it's just necesary to separate tags by one space or more.
- Library: Added methods to sort Tasks by alphabetical order, due date and priority.
- Tests: Rewritten tests for all major cases (some edge cases might be necesary to test).
- Documentation: Updated Task docs
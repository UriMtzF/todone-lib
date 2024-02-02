A library made to parse Todone style tasks.
## Features 
This library can create a List of Task objects based on the ToDone standard [see more](#todone-standard).

It can create the List from:
- File object
- File path (String)
- String correctly formatted

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
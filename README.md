# Safe RM

> Safe RM can be used in place of the rm command to move files to a trash directory which can be restored.

## Usage

The saferm command takes no options, everything will be moved regardless of whether or not it is a directory.  So the command to delete anything is as follows:

```bash
saferm [filesToDelete...]
```

There are also commands to list the deleted files and empty the trash.  These commands are `lstr` and `emtr` respectively.

*Note:* All groups of files deleted at the same time are put into a directory with the timestamp of their deletion time.

## Making it convenient

In order to make use of this command more easily, I recommend that you place `alias rm="saferm"` in your `.bashrc`.  You can always access the original `rm` command using `\rm`.

## License

MIT

Copyright (c) 2016 Victor Johnson vicjohnson1213@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
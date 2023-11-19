# Man Reader - A nice command-line viewer for man pages

> :fr: French documentation available [here](/docs/README.fr.md)

> :warning: This script needs bash version >=4 to run
> You can check your version with `bash --version`

<blockquote>

:bulb: A new version with a lot of fixes, and 
that run autoupdates is available! You can run 
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh) -i
```
to install

</blockquote>

## Preamble - How to navigate the man ?

You must already know that we can use the mouse scroll and the ups and down
arrows to navigate the `man`. However, as it is a tool design for command-line,
there are some shortcut keys that allow us to navigate it more quickly :
- `j` : Pressing `j` takes us 1 line forward. We can add a number before `j` \
to go `n` lines forward. For example `6j` takes us six lines ahead.
- `k` : Pressing `k` takes us 1 line back. We can also add a number before the \
`k`.
- `g` : Pressing `g` takes us to the top of the man page
- `G` : Pressing `G` (Shift + g) takes us to the bottom of the man page
- `f` : Pressing `f` takes us one full screen ahead. We can also press the spacebar \
to achieve the same result.
- `b` : Pressing `b` takes us one screen back
- `d` : Pressing `d` takes us half a window forward
- `u` : Pressing `u` takes us half a window back
- `q` : Pressing `q` allows us to exit the man page

## What does this script do ?

### Short intro

This script allow you to navigate the man pages in a more friendly manner
To do so, it parses the man page to retrieve the sections and subsections
It then outputs a table of contents that looks like this one
(Example is from `man man.1` man page, which is like `man 1 man`)

![man 1 man table of contents](/assets/man1_toc.png "man 1 man")

### Basic actions

After printing the table of contents, it prompts the user with an action
The following actions are available to the user :
- `number` : A number between 1 and the number of sections (18 on our example) \
entering an invalid section number quits the man page rendering
- `n` : renders the next section of the man page. Pressing `n` at the first section \
will render the first section while pressing `n` at the end will exit the page rendering \
and prompt the user for another man page to read
- `p` : renders the previous section of the man page
- `k` : calls the utility `clear` to clear the terminal output
- `s` : prints the sections of the man page
- `q` : quits the man page rendering


### Section rendering

Let's try, for example, to print the number `8`. We get this output in the terminal :

![man.1 section 7.1](/assets/man1-8.png "section 7.1 of man in section 1")

> :bulb: When rendering any page, you can press `k` to pad with spaces on the bottom.
> This gives us the following output : 

![man.1 section 7.1 padded](/assets/man1-8_padded.png "section 7.1 of man in section 1 with padding")

> :warning: Beware that at the present time, this script doesn't distinguish between rendering
> sections and subsections. This means that, if we decide to render the section 7 (number 7 on our example)
> the script will render from number 7 to number 8, which is the part of section 7 that is before the first
> subsection

That is, if we try for example to print the number `7` instead of number `8`. We get the following output :

![man.1 section 7](/assets/man1-7.png "section 7 of man in section 1")

## How to use this script ?

### Run from online source

To run the script, you can run the following command in your terminal

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh)
```

<blockquote>

:bulb: You can run 
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh) bash 30
```
For more information about **Process Substitution**

</blockquote>

It will then prompt the main menu and the script will be able to be used as explained above.

When running the script that way, arguments can be provided on the command line as if it was run with `./man_reader.sh`.

### Local install

To install the script locally, at `$HOME/.local/bin/man_reader`, you can run 
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh) -i
```
Then, if you add the path `$HOME/.local/bin` to the variable PATH, you will be able to run the script with
```bash
man_reader
```

> :bulb: You can add the line `export PATH="$PATH:$HOME/.local/bin/"` to your `~/.bashrc` or `~/.zshrc` file if you're
> using bash or zsh as your login shell.

### Only prints toc

To print only the table of content, you can run
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh) -l [page]
```
With an optionnal page as an argument. If no page is entered, you will be prompted for a man page when the script starts
It will then print the toc of said man page and exit

### Read only one page (no main menu)

When running the following command :
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh) page [section]
```
You can print the required page (which can be passed as an argument with the format page.man\_section)
- If no (optionnal) section is provided, it will open the main menu for the required man page and exit when asked for
- If a section is provided, it will print the required section in the required man\_page (if found). Section can be specified \
in two formats :
	- A number (between 1 and the number of section in the toc) (ex : `man_reader bash 30`)
	- A string describing the section (ex : `man_reader bash 'Process Substitution'`). Don't forget the `"` or `'` so that \
the section string is treated as one argument.

### Get help

Run the following command :
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nsainton/man_reader/master/man_reader.sh) -h
```
To get help

## Contributing

There are two ways to contribute to this project
- Send me a message on discord (for 42 students) or to the following [email](mailto:nsainton@student.42.fr?subject=[man_reader])
- Pull requests that are currently closed but are going to be oppened soon for you to add all your amazing features to the project

## Demo Video

Click on the picture to open the video on youtube

[![preview](/assets/preview.png)](https://youtu.be/no9y0Kk-3hs)
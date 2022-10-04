# Shell Useful Commands

- print all non-comment and non-emoty lines

First, we got a file `test.txt` with the lines:

```
\ this is a comment
\* this is another comment

int main(){
	int a = 1;
}
```
then, `-E` allows extended regex, `-v` grabs all the lines that **don't** match the regex, and `\s` means a space, tab or any empty char.

```bash
grep -vE '(\\\\|\\\*|^(\s)*$' test.txt
```

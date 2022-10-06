# Shell Useful Commands

- Print all non-comment and non-empty lines

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
grep -vE '(\\\\|\\\*|\*\\|^(\s)*$)' test.txt
```
- Use Logitech c270 Webcam on a Raspberry Pi 3

```bash
sudo apt-get install guvcview
sudo usermod -a -G video pi
sudo modprobe uvcvideo
sudo reboot
guvcview --resolution=544x288 -format=yuyv
sudo rmmod uvcvideo
sudo modprobe uvcvideo
guvcview --resolution=544x288 -format=yuyv
```

It will open a window showing the camera view:

![img](my_photo-1.jpg)

![img](my_photo-2.jpg)

*Note: the webcam must be plugged when you reboot.*


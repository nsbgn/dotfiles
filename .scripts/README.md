Scripts
===============================================================================

Here you will find nifty scripts I wrote to make my life easier. The main 
repository is at [github](https://github.com/slakkenhuis/scripts).

Most of them are pretty messy and only intended for personal use, but I did 
try to make them small and easy to change, so have a look around and do 
with them as you please. I'm fond of using 
[`dmenu`](http://tools.suckless.org/dmenu/) and 
[`jq`](https://stedolan.github.io/jq/), because they make quick DIY 
scripts easy. You may symlink `dmenu` to an alternative like 
[`bemenu`](https://github.com/Cloudef/bemenu), 
[`rofi`](https://github.com/davatorium/rofi), 
[`wofi`](https://hg.sr.ht/~scoopta/wofi), 
[`yofi`](https://github.com/l4l/yofi), or 
[`tofi`](https://github.com/philj56/tofi).

Currently, the repository contains the following tools:

- [dmenu-mpv](dmenu-mpv): An interface to [mpv](https://mpv.io/), as a plain 
  music player that simply offers a shuffled list of full albums to play.
- [dmenu-pass](dmenu-pass): An interface to 
  [pass](http://www.zx2c4.com/projects/password-store/), as a password 
  manager.
- [dmenu-thesaurus](dmenu-thesaurus): Present a list of related words by 
  quickly parsing [freethesaurus.com](https://freethesaurus.com) with 
  [htmlq](https://github.com/mgdm/htmlq).
- [xcwd.sh](xcwd.sh): an alternative to 
  [xcwd](https://github.com/schischi/xcwd), 
  [lastcwd](https://github.com/wknapik/lastcwd) and
  [i3-shell](https://gist.github.com/viking/5851049#file-i3-shell-sh) that 
  returns the working directory of the currently active terminal window, even 
  for urxvt.
- [toggle-pointer](toggle-pointer): A script to disable and re-enable the 
  mouse pointer.
- [download-article](download-article) downloads an internet article to a 
  Markdown file.
- [crsync](crsync): A script to keep my files synchronised across my devices 
  (ereader, music player, external harddisk, etcetera), by running 
  [rsync](https://rsync.samba.org/) on a YAML configuration.
- [block](block): Easily blocking websites through `/etc/hosts`.
- [printer](printer): Print PDFs as double-sided booklets on cheap printers 
  without automatic double-sided printing.
- [scanner](scanner): The command I use for making quick scans. Photographs 
  are automatically separated, cropped, and de-rotated, whereas documents are 
  made black-and-white and heavily compressed.
- [diffpic](diffpic): A quick script to identify and delete duplicate or 
  visually similar images using 
  [findimagedupes](http://www.jhnc.org/findimagedupes/) and 
  [sxiv](https://github.com/muennich/sxiv).


### Notices

- `keyboard-config` has been reworked into 
  [thumbledore](https://github.com/slakkenhuis/thumbledore)

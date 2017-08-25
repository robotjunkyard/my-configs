#!/bin/bash
## Still can't quite get uim-fep and fbterm to play 100% nicely...

#### LANG=ja_JP.utf-8 ; export LANG
clear
uim-fep -u mozc &
fbterm -- uim-fep -u mozc
reset




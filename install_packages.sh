#!/bin/bash

PACKS=`cat pacman.txt`
echo $PACKS
sudo pacman -S $PACKS
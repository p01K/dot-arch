#!/usr/bin/python
import os
import shutil
import argparse

user = os.environ['USER']

print(user)

def install(key):
    source_path, dest_path = filedict[key]
    print(os.path.isfile(source_path))
    print(os.path.isfile(dest_path))
    #shutil.copyfile(source_path,dest_path)
    return (source_path, dest_path)


filedict = {
"alacritty":"home/",
"tmux":("home/tmux.conf","/home/{}/.tmux.conf".format(user)),
"zshrc":("home/zshrc","/home/{}/.zshrc".format(user)),
"Xresources":("home/Xresources","/home/{}/.Xresources".format(user))
}

if__name__== "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('-m', '--mod', type=str, required=True)

    args = parser.parse_args()

    print(args.mod)
    print(filedict.contains_key(args.mod))
    print(install("tmux"))

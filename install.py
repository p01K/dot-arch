#!/usr/bin/python
import os
import shutil
import argparse

user = os.environ['USER']

def install(key):
    source_path, dest_path = filedict[key]
    assert(os.path.isfile(source_path))
    #assert(os.path.isfile(dest_path))
    shutil.copyfile(source_path,dest_path)
    return (source_path, dest_path)

def install_all(keylist):
    for k in keylist:
        install(k)

USER_HOME="/home/{}".format(user)

filedict = {
"alacritty"  :("home/alacritty/alacritty.yml","{}/.config/alacritty/alacritty.yml"),
"tmux"       :("home/tmux.conf","{}/.tmux.conf"),
"zshrc"      :("home/zshrc.zsh","{}/.zshrc"),
"zlogin"     :("home/zlogin","{}/.zshrc"),
"Xresources" :("home/Xresources","{}/.Xresources"),
"micro"      :("home/micro/bindings.json","{}/.config/micro/bindings.json"),
"i3"         :("i3/i3config","{}/.config/i3/config"),
"i3status"   :("i3/i3status.conf","{}/.i3status.conf")
}

for k in filedict.keys():
    (src,dst)   = filedict[k]
    filedict[k] = (src,dst.format(USER_HOME))

if __name__== "__main__":

    parser   = argparse.ArgumentParser()
    help_msg = "possible modules {}".format(filedict.keys())
    parser.add_argument('-m', '--mod', type=str, required=True, help=help_msg)
    args     = parser.parse_args()

    print(args.mod)
    install(args.mod)

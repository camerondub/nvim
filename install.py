#!/usr/bin/env python3
import os
from invoke import run

if __name__ == "__main__":
    run("rm -f ~/.config/nvim")
    run("ln -s ~/.config/cw/nvim ~/.config/nvim")

#!/usr/bin/env python

"""Hello, world

This is a simple program that prints "Hello, world" to the console.
You can add a --name argument to use a name other than "world".
"""

import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Hello, world')
    parser.add_argument('--name', default="world", help='Name to greet')
    args = parser.parse_args()
    print("Hello, {}!".format(args.name))

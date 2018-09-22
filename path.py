#!/usr/bin/python
# -*- coding: latin1 -*-
"""
import os

def list_files(startpath):

    with open("folder_structure.txt", "w") as f_output:
        for root, dirs, files in os.walk(startpath):
            level = root.replace(startpath, '').count(os.sep)
            indent = '\t' * 1 * (level)
            output_string = '{}{}/'.format(indent, os.path.basename(root))
            print(output_string)
            f_output.write(output_string + '\n')
            subindent = '\t' * 1 * (level + 1)
            for f in files:
                output_string = '{}{}'.format(subindent, f)
                print(output_string)
                f_output.write(output_string + '\n')

list_files(".")
"""

from pathlib import Path
from sys import argv
import sys
import os

arq_caminho = {}

class DisplayablePath(object):
    display_filename_prefix_middle = '|--'
    display_filename_prefix_last = '|--'
    display_parent_prefix_middle = '    '
    display_parent_prefix_last = '|   '

    def __init__(self, path, parent_path, is_last):
        self.path = Path(str(path))
        self.parent = parent_path
        self.is_last = is_last
        if self.parent:
            self.depth = self.parent.depth + 1
        else:
            self.depth = 0

    @property
    def displayname(self):
        if self.path.is_dir():
            return self.path.name + '/'
        return self.path.name

    @classmethod
    def make_tree(cls, root, parent=None, is_last=False, criteria=None):
        root = Path(str(root))
        criteria = criteria or cls._default_criteria

        displayable_root = cls(root, parent, is_last)
        yield displayable_root

        children = sorted(list(path
                               for path in root.iterdir()
                               if criteria(path)),
                          key=lambda s: str(s).lower())
        count = 1
        for path in children:
            is_last = count == len(children)
            if path.is_dir():
                #arq_caminho[os.path.basename(path)] = os.path.basename(path)
                yield from cls.make_tree(path,
                                         parent=displayable_root,
                                         is_last=is_last,
                                         criteria=criteria)
            else:
                arq_caminho[os.path.basename(path)] = str(path)
                yield cls(path, displayable_root, is_last)
            count += 1

    @classmethod
    def _default_criteria(cls, path):
        return True

    @property
    def displayname(self):
        if self.path.is_dir():
            return self.path.name + '/'
        return self.path.name

    def displayable(self):
        if self.parent is None:
            return self.displayname

        _filename_prefix = (self.display_filename_prefix_last
                            if self.is_last
                            else self.display_filename_prefix_middle)

        parts = ['{!s} {!s}'.format(_filename_prefix,
                                    self.displayname)]

        parent = self.parent
        #print( self.displayname )
        while parent and parent.parent is not None:
            parts.append(self.display_parent_prefix_middle
                         if parent.is_last
                         else self.display_parent_prefix_last)
            parent = parent.parent
		
        if self.displayname in arq_caminho:
            return str(''.join(reversed(parts))) + '\t\t>> [' + arq_caminho[self.displayname] + ']'
        else:
            return str(''.join(reversed(parts)))



# path.py D:\Documentos\editor-gtk-c D:\Documentos\editor-gtk-c\textedit\teste.txt

def main():
    output_file = open(argv[2],'w')
    paths = DisplayablePath.make_tree(Path(argv[1]))
    for path in paths:
        output_file.write(path.displayable())
        output_file.write('\n')

if __name__ == '__main__':
    main()

"""
output_file = open("D:\\Documentos\\editor-gtk-c\\textedit\\ok.txt",'w')
paths = DisplayablePath.make_tree(Path("D:\\Documentos\\editor-gtk-c"))
for path in paths:
        print(path.displayable())
        output_file.write(path.displayable())
        output_file.write('\n')
"""

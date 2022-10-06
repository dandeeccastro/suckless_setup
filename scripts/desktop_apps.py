#!/usr/bin/python

import os
import subprocess

home = os.path.expanduser('~')

directories = ['/usr/share/applications/', '{}/.local/share/applications/'.format(home)]
dfiles = dict()

print(directories)

for directory in directories:
    print('Checking {}'.format(directory))
    for path in os.listdir(directory):
        print('File is {}, comparisons {} {}'.format(path,os.path.isfile(os.path.join(directory, path)) , '.desktop' in path))
        if os.path.isfile(os.path.join(directory, path)) and '.desktop' in path:

            full_file_path = os.path.join(directory, path)
            data = open(full_file_path).read()
            name = data.split('Name=')[1]

            if '\n' in name:
                name = name.split('\n')[0]

            dfiles[name] = path[:len(path) - 8]

process = subprocess.Popen(["dmenu"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
process_input = bytes('\n'.join(dfiles.keys()), 'utf-8')
dmenu_output = process.communicate(input=process_input)[0]

chosen_file = dmenu_output.decode().strip()

print(chosen_file, dfiles[chosen_file])
subprocess.run(['gtk-launch', dfiles[chosen_file]])

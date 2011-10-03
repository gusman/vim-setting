#!/usr/in/python

import os
from os.path import join, getsize

# This folder for tutorial only
src_dir = "D:\\codes\\alsa-driver-1.0.9"
cscope_dir = "D:\\codes\\cscope-filegen\\cscope"
cscope_db = cscope_dir + "\\cscope.files"

# script start from here

if os.path.isdir(src_dir):
    print "OK"

if os.path.isdir(cscope_dir):
    print "OK"

f = open(cscope_db, 'w') 

for root, dirs, files in os.walk(src_dir):
    for name in files:
        iswrite = 0;
        ext = name[len(name)-2:len(name)]
        
        if ".c" == ext:
            iswrite = 1
        elif ".h" == ext:
            iswrite = 1

        if iswrite:
            filename = root + "\\" + name +"\n"
            f.write(filename)

f.close()

    #print sum([getsize(join(root, name)) for name in files]),
    #print "bytes in", len(files), "non-directory files"
    #if 'CVS' in dirs:
    #    dirs.remove('CVS')  # don't visit CVS directories


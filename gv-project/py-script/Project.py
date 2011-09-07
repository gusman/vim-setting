#!/usr/bin/python

import os
from Config import FileConfig

class Project(FileConfig):
    def __init__(self, filename=''):
        FileConfig.__init__(self, filename)

    def gen_ctags(self):
        print ">> GENERATE CTAGS FILE"
        cmd = "ctags -R "  + " -o " + self.get_ctagsfile() + " " + self.get_srcdir()
        os.system(cmd)

    def gen_csope(self):
        print ">> GENERATE CSCOPE FILE"

myPrj = Project()
myPrj.set_filename("D:\\git\\vim-setting\\gv-project\\prj-info\\py-script.conf")
myPrj.set_confdir("D:\\git\\vim-setting\\gv-project\\prj-info")
myPrj.set_srcdir("D:\\git\\vim-setting\\gv-project\\py-script")
myPrj.set_ctagsfile(myPrj.get_confdir() + "\\" + "tags")
myPrj.gen_ctags()


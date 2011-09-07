#! /usr/bin/python

import os

class FileConfig:
    def __init__(self, filename=''): 
        self.filename = filename
        self.projectname = ''
        self.srcdir = ''
        self.confdir = ''
        self.ctagsfile = ''
        self.cscopefile = ''

    def parse_file(self):
        tmp = ''
        rmod = -1
        self.clear_attr()

        f = open(self.filename, 'r')
        while True:
            c = f.read(1)
            if (0 == len(c)):
                break

            if '#' != c:
                if (1 == rmod): self.projectname += c
                elif (2 == rmod): self.ctagsfile += c
                elif (3 == rmod): self.cscopefile += c
                elif (4 == rmod): self.srcdir += c
                elif (5 == rmod): self.confdir += c
                elif (0 == rmod): tmp += c
            else:
                if ('PRJN' == tmp): rmod = 1
                elif ('CTAG' == tmp): rmod = 2
                elif ('CSCP' == tmp): rmod = 3
                elif ('SRCD' == tmp): rmod = 4
                elif ('CONF' == tmp): rmod = 5
                else: rmod = 0

        tmp = ''
        f.close()

    def dump_tofile(self):
        f = open(self.filename, 'w')
        f.write("#PRJN#" + self.projectname + "#\n" \
                "#CTAG#" + self.ctagsfile + "#\n" \
                "#CSCP#" + self.cscopefile + "#\n" 
                "#SRCD#" + self.srcdir + "#\n" \
                "#CONF#" + self.confdir + "#\n" ) 

    def set_filename(self, filename):
        self.filename = filename

    def set_projectname(self, prj_name):
        self.projectname = prj_name

    def set_ctagsfile(self, ctags_file):
        self.ctagsfile = ctags_file

    def set_cscopefile(self, cscope_file):
        self.cscopefile = cscope_file

    def set_srcdir(self, srcdir):
        self.srcdir = srcdir

    def set_confdir(self, confdir):
        self.confdir = confdir

    def get_filename(self):
        return self.filename

    def get_projectname(self):
        return self.projectname

    def get_ctagsfile(self):
        return self.ctagsfile

    def get_cscopefile(self):
        return self.cscopefile

    def get_srcdir(self):
        return self.srcdir

    def get_confdir(self):
        return self.confdir


    def clear_attr(self):
        self.projectname = ''
        self.ctagsfile = ''
        self.cscopefile = ''
        self.srcdir = ''
        self.confdir = ''

    def is_fileexist(self):
        return os.path.isfile(self.filename)
          
    def info(self):
        print "Filename: " + self.filename
        print "Projectname: " + self.projectname
        print "Ctagsfile: " + self.ctagsfile
        print "Cscopefile: " + self.cscopefile
        print "srcdir: " + self.srcdir
        print "confdir: " + self.confdir

#! /usr/bin/python

import os
import vim
import platform
from os.path import join, getsize

debug = 1

def dir_trim(str):
    if 0 == len(str):
        return -1

    if '/' != str[len(str) - 1]:
        str = str + '/'
    return str

def str_trim(str):
    if '\n' == str[len(str) - 1]:
        str = str[:-1]
    return str
  
def gv_dumptofile(filepath, projectname, \
                ctagsfile, cscopedb, srcdir, confdir ):
    if debug == 1:
        print ">> DUMP to FILE"

    f = open(filepath, 'w')
    f.write("#PRJN#" + projectname + "#\n" \
            "#CTAG#" + ctagsfile + "#\n" \
            "#CSCP#" + cscopedb + "#\n" 
            "#SRCD#" + srcdir + "#\n" \
            "#CONF#" + confdir + "#\n" ) 
    f.close()

def gv_parsefile(filepath):
    if debug == 1:
        print ">> PARSE FILE"

    projectname = ''
    ctagsfile = ''
    cscopedb = ''
    srcdir = ''
    confdir = ''

    rmod = -1
    tmp = ''

    f = open(filepath, 'r')
    while True:
        c = f.read(1)
        if (0 == len(c)):
            break

        if '#' != c:
	    if 1 == rmod: projectname += c
            elif 2 == rmod: ctagsfile += c
            elif 3 == rmod: cscopedb += c
            elif 4 == rmod: srcdir += c
            elif 5 == rmod: confdir += c
            elif 0 == rmod: tmp += c
        else:
            if 'PRJN' == tmp: rmod = 1
            elif 'CTAG' == tmp: rmod = 2
            elif 'CSCP' == tmp: rmod = 3
            elif 'SRCD' == tmp: rmod = 4
            elif 'CONF' == tmp: rmod = 5
            else: rmod = 0
            tmp = ''

    f.close()
    lval = [projectname, ctagsfile, cscopedb, srcdir, confdir]
    return lval

def gv_getconfig(filepath):
    if debug == 1:
        print ">> GET CONFIG"

    lval = gv_parsefile(filepath)
    vim.command("let g:prj_name = '" + lval[0] + "'")
    vim.command("let g:ctags_file = '" + lval[1] + "'")
    vim.command("let g:cscope_db = '" + lval[2] + "'")
    vim.command("let g:src_dir = '" + lval[3] + "'")
    vim.command("let g:conf_dir = '" + lval[4] + "'");

def gv_saveconfig():
    if debug == 1:
        print ">> SAVE CONFIG"

    filepath = vim.eval("g:prj_conf_filename")
    projectname = vim.eval("g:prj_name")
    ctagsfile = vim.eval("g:ctags_file")
    cscopedb = vim.eval("g:cscope_db")
    srcdir = vim.eval("g:src_dir")
    confdir = vim.eval("g:conf_dir")

    gv_dumptofile(filepath, projectname, ctagsfile, \
                cscopedb, srcdir, confdir)

def gv_gentags():
    if debug == 1:
        print ">> GEN TAGS"

    ctagsfile = vim.eval("g:ctags_file")
    srcdir = vim.eval("g:src_dir")
    cmd = "ctags -RV "  + " -o " + ctagsfile + " " + srcdir
    os.system(cmd)

def gv_settags():
    if debug == 1:
        print ">> SET TAGS"

    ctagsfile = vim.eval("g:ctags_file")
    if not os.path.isfile(ctagsfile):
        print "CTAGS FILE: " + ctagsfile + " -> Not exist!"
        return

    # I don't know, why the command must be in variable
    # If not in variable, command will not run properly
    cmd = "set tags=" + ctagsfile   
    print cmd
    vim.command(cmd)

def gv_updatetags():
    if debug == 1:
        print ">> UDPATE TAGS"
    gv_gentags()
    gv_settags()

def gv_gencscope():
    confdir = vim.eval("g:conf_dir")
    srcdir = vim.eval("g:src_dir")
    confdir = dir_trim(confdir)
    cscopefile = confdir + "cscope.files"

    if not os.path.isdir(confdir) :
        print confdir + ": NOT EXIST"
        return

    # generate cscope files
    f = open(cscopefile, 'w') 
    for root, dirs, files in os.walk(srcdir, followlinks=True):
        for name in files:
            iswrite = 0;
            ext1 = name[len(name)-2:len(name)]
            ext2 = name[len(name)-4:len(name)]
            
            if ".c" == ext1 or ".C" == ext1:
                iswrite = 1
            elif ".h" == ext1 or ".H" == ext1:
                iswrite = 1
            elif ".cpp" == ext2 or ".CPP" == ext2:
                iswrite = 1

            if iswrite:
                filename = root + '/' + name +"\n"
                #print filename[:len(filename)-1]
                f.write(filename)
    f.close()

    # generate cscope database
    os.chdir(confdir)
    cmd = "cscope -b -k -v"

    # if in Linux add reverse database
    if platform.system() == 'Linux':
        cmd += " -q"

    os.system(cmd)

def gv_addcscope():
    cscopedb = vim.eval("g:cscope_db")
    if os.path.isfile(cscopedb):
        cmd = "cs add " + cscopedb
        vim.command(cmd)
    else:
        print "CSCOPE DB FILE NOT EXIST"

def gv_loadlist():
    confdir = vim.eval("g:conf_dir")
    srcdir = vim.eval("g:src_dir")
    confdir = dir_trim(confdir)
    cscopefile = confdir + "cscope.files"

    if not os.path.isfile(cscopefile) :
        print confdir + ": NOT EXIST"
        return

    print "Loading file"

    # generate cscope files
    f = open(cscopefile, 'r') 
    while True:
	path = f.readline()
	if (0 == len(path)):
	    break;
	path = path[0:len(path) - 1]
	cmd = "call add(g:alist,\"" + path + "\")"
	vim.command(cmd)

    print "Finish"

    f.close()

def gv_load(prjconf=".gvproj/prj.conf"):
    if not os.path.isfile(prjconf):
        print prjconf + ": NOT EXIST!"
        return

    gv_getconfig(prjconf)
    gv_settags()
    gv_addcscope()
    gv_loadlist()

def gv_init():
    #gvdir = vim.eval("g:gv_dir")
    #prjname = vim.eval("g:prj_name")

    #if not os.path.isdir(gvdir):
    #    os.mkdir(gvdir)

    # create conf dir in root folder of source code
    srcdir = vim.eval("g:src_dir")
    if not os.path.isdir(srcdir):
        print srcdir + ": Not exists"
        return

    srcdir = dir_trim(srcdir)
    confdir = srcdir + ".gvproj"
    if not os.path.isdir(confdir):
        os.mkdir(confdir)
    vim.command("let g:conf_dir = '" + confdir + "'")

    # create proj conf file
    confdir = dir_trim(confdir)
    prj_conf_filepath = confdir + "prj.conf"
    vim.command("let g:prj_conf_filename = '" + prj_conf_filepath + "'")

    # set tagsfile global variable
    ctagsfile = confdir + "tags"
    vim.command("let g:ctags_file = '" + ctagsfile + "'")
    
    # set cscopefile global variable
    cscopedb = confdir + "cscope.out"
    vim.command("let g:cscope_db = '" + cscopedb + "'")

    # save configuration
    gv_saveconfig()

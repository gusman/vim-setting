#! /usr/bin/python

import os
import vim

debug = 1

def dir_trim(str):
    if '\\' != str[len(str) - 1]:
        str = str + '\\'
    return str

def str_trim(str):
    if '\n' == str[len(str) - 1]:
        str = str[:-1]
    return str
  
def gv_dumptofile(filepath, projectname, \
                ctagsfile, cscopefile, srcdir, confdir ):
    
    if debug == 1:
        print ">> DUMP to FILE"

    f = open(filepath, 'w')
    f.write("#PRJN#" + projectname + "#\n" \
            "#CTAG#" + ctagsfile + "#\n" \
            "#CSCP#" + cscopefile + "#\n" 
            "#SRCD#" + srcdir + "#\n" \
            "#CONF#" + confdir + "#\n" ) 
    f.close()

def gv_parsefile(filepath):

    if debug == 1:
        print ">> PARSE FILE"

    projectname = ''
    ctagsfile = ''
    cscopefile = ''
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
            elif 3 == rmod: cscopefile += c
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
    lval = [projectname, ctagsfile, cscopefile, srcdir, confdir]
    return lval

def gv_getconfig():
    if debug == 1:
        print ">> GET CONFIG"

    filepath = vim.eval("g:prj_conf_filename")
    lval = parse_file(filepath)
    
    vim.command("let g:prj_name = '" + lval[0] + "'")
    vim.command("let g:ctagsfile = '" + lval[1] + "'")
    vim.command("let g:cscopefile = '" + lval[2] + "'")
    vim.command("let g:src_dir = '" + lval[3] + "'")
    vim.command("let g:conf_dir = '" + lval[4] + "'");

def gv_saveconfig():
    if debug == 1:
        print ">> SAVE CONFIG"

    filepath = vim.eval("g:prj_conf_filename")
    projectname = vim.eval("g:prj_name")
    ctagsfile = vim.eval("g:ctags_file")
    cscopefile = vim.eval("g:cscope_file")
    srcdir = vim.eval("g:src_dir")
    confdir = vim.eval("g:conf_dir")

    gv_dumptofile(filepath, projectname, ctagsfile, \
                cscopefile, srcdir, confdir)

def gv_gentags():
    if debug == 1:
        print ">> GENT TAGS"

    ctagsfile = vim.eval("g:ctags_file")
    srcdir = vim.eval("g:src_dir")
    cmd = "ctags -R "  + " -o " + ctagsfile + " " + srcdir
    os.system(cmd)

def gv_settags():
    if debug == 1:
        print ">> SET TAGS"

    ctagsfile = vim.eval("g:ctags_file")

    # I don't know, why the command must be in variable
    # If not in variable, command will not run properly
    cmd = "set tags=" + ctagsfile   
    vim.command(cmd)

def gv_updatetags():
    if debug == 1:
        print ">> UDPATE TAGS"

    gv_gentags()
    gv_settags()

def gv_init():
    gvdir = vim.eval("g:gv_dir")
    prjname = vim.eval("g:prj_name")

    if not os.path.isdir(gvdir):
        os.mkdir(gvdir)

    gvdir = dir_trim(gvdir)
    confdir = gvdir + prjname
    if not os.path.isdir(confdir):
        os.mkdir(confdir)

    confdir = dir_trim(confdir)
    prj_conf_filepath = confdir + "prj.conf"
    vim.command("let g:prj_conf_filename = '" + prj_conf_filepath + "'")

    ctagsfile = confdir + "tags"
    vim.command("let g:ctags_file = '" + ctagsfile + "'")

    gv_saveconfig()

#! /usr/bin/python

import os
import vim
import platform
import threading
import time
import subprocess
import queue
from os.path import join, getsize

debug = True
global_devmode = False
global_config = {}
global_timer = None
global_lock = threading.Lock()

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
  
def gv_parsefile(filepath):
    if debug == True:
        print(">> PARSE FILE")

    global global_config
    tmp = ''
    project_name = ''
    confdir = ''
    srcdir = []

    f = open(filepath, 'r')

    while True:
        tmp = f.readline()

        if "#1" == tmp[0:2]:
            projectname = f.readline()
            projectname = projectname[0:len(projectname)-1] 

        elif "#2" == tmp[0:2]:
            confdir = f.readline()
            confdir = confdir[0:len(confdir)-1]

        elif '>' == tmp[0]:
            srcdir.append(tmp[1:len(tmp)-1])
            continue

        elif "#EOF" == tmp[0:4]:
            break;

    f.close()
    ctagsfile = confdir + "/tags"
    cscopedb  = confdir + "/cscope.out"

    global_config['PROJECT_NAME'] = project_name
    global_config['CONF_DIR'] = confdir
    global_config['SRC_DIR'] = srcdir
    global_config['CTAGS_FILE'] = ctagsfile
    global_config['CSCOPE_DB'] = cscopedb
    #print global_config

def gv_getconfig(filepath):
    if debug == True:
        print(">> GET CONFIG")
    
    global global_config
    gv_parsefile(filepath)
  
def gv_writelist(fobj, srcdir):
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
                fobj.write(filename)

def gv_collectsrc():
    global global_config

    srcdir = []
    confdir = global_config['CONF_DIR']
    srcdir = global_config['SRC_DIR']
    confdir = dir_trim(confdir)
    srclist = confdir + "project.files"

    if not os.path.isdir(confdir):
        print(confdir + ": NOT EXIST")
        return

    # generate list of files
    f = open(srclist, 'w') 

    for item_dir in srcdir:
        if not os.path.isdir(item_dir):
            continue
        gv_writelist(f, item_dir);

    f.close()

def gv_gentags(verbose = True):
    if True == debug and True == verbose:
        print(">> GEN TAGS")

    global global_config

    confdir = global_config['CONF_DIR']
    confdir = dir_trim(confdir)
    srclist = confdir + "project.files"

    if not os.path.isfile(srclist):
        print(srclist + " NOT EXIST")
        return 

    ctagsfile = global_config['CTAGS_FILE']
    cmd = "ctags " 
    
    if True == verbose:
        cmd += " -V "
    
    cmd += " --c-kinds=+p --c++-kinds=+p --fields=+iaSl --extra=+q " + \
        " -o " + ctagsfile +  " -L " + srclist

    #os.system(cmd)
    subprocess.call(cmd, shell = True)

def gv_settags():
    if debug == True:
        print(">> SET TAGS")
    
    global global_config

    ctagsfile = global_config['CTAGS_FILE']
    if not os.path.isfile(ctagsfile):
        print("CTAGS FILE: " + ctagsfile + " -> Not exist!")
        return

    # I don't know, why the command must be a variable
    # If it is not a variable, command will not run properly
    cmd = "set tags=" + ctagsfile   
    print(cmd)
    vim.command(cmd)

def gv_updatetags():
    if debug == True:
        print(">> UDPATE TAGS")
    gv_gentags()
    gv_settags()

def gv_gencscope(verbose = True):
    global global_config

    confdir = global_config['CONF_DIR']
    confdir = dir_trim(confdir)
    srclist  = confdir + "project.files"
    cscopeout = confdir + "cscope.out"

    gv_collectsrc()
    if not os.path.isfile(srclist):
        print(srclist + " NOT EXIST")
        return 

    # generate cscope database
    cmd = "cscope -b -k "

    if True == verbose:
        cmd += " -v "

    # if on Linux add reverse database
    if platform.system() == 'Linux':
        cmd += " -q "

    cmd += "-i " + srclist + " -f " + cscopeout
    #os.system(cmd)
    subprocess.call(cmd, shell = True)

def gv_addcscope():
    global global_config

    cscopedb = global_config['CSCOPE_DB']
    if os.path.isfile(cscopedb):
        cmd = "cs add " + cscopedb
        vim.command(cmd)
    else:
        print("CSCOPE DB FILE NOT EXIST")

def gv_bg_update():
    global global_lock
    global_lock.acquire()
    gv_gentags(False)
    gv_gencscope(False)
    vim.command("silent! cs reset")
    print("Updating done")
    global_lock.release()

# // disable loadlist since using ctrlp
#def gv_loadlist():
#    global global_config
#
#    confdir = global_config['CONF_DIR']
#    confdir = dir_trim(confdir)
#    cscopefile = confdir + "project.files"
#
#    if not os.path.isfile(cscopefile) :
#        print confdir + ": NOT EXIST"
#        return
#
#    print "Loading file"
#
#    # generate cscope files
#    f = open(cscopefile, 'r') 
#    while True:
#	path = f.readline()
#	if (0 == len(path)):
#	    break;
#	path = path[0:len(path) - 1]
#	if platform.system() == 'Linux':
#	    cmd = "call add(g:alist,\"" + path + "\")"
#	else:
#	    cmd = "call add(g:alist,'" + path + "')"
#	vim.command(cmd)
#
#    print "Finish"
#
#    f.close()

def gv_activate_timer():
    global global_devmode

    if True == global_devmode:
        global global_timer

        if not(None == global_timer) and global_timer.isAlive():
            global_timer.cancel()

        global_timer = threading.Timer(3, gv_bg_update)
        global_timer.start()
    
def gv_add_task():
    gv_activate_timer()

def gv_set_bookmark_file():
    global global_config
    confdir = global_config['CONF_DIR']
    confdir = dir_trim(confdir)
    cmd = "let g:simple_bookmarks_filename = "
    cmd += "'" + confdir + "vim_bookmark" + "'"
    print(cmd)
    vim.command(cmd)

def gv_load(prjconf=".gvproj/prj.conf"):
    if not os.path.isfile(prjconf):
        print(prjconf + ": NOT EXIST!")
        return

    gv_getconfig(prjconf)
    gv_settags()
    gv_addcscope()
    gv_set_bookmark_file()
    #gv_loadlist()
    global global_devmode
    global_devmode = True

def gv_init(prjconf=".gvproj/prj.conf"):
    if not os.path.isfile(prjconf):
        print(prjconf + ": NOT EXIST!")
        return

    gv_getconfig(prjconf) 
    gv_collectsrc()
    #gv_loadlist()
    gv_gentags()
    gv_gencscope()
    gv_settags()
    gv_addcscope()
    gv_set_bookmark_file()

    global global_devmode
    global_devmode = True


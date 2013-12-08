#! /usr/bin/python

import os
import vim
import platform
from os.path import join, getsize

debug = 1
global_config = {}

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
    if debug == 1:
        print ">> PARSE FILE"

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
    if debug == 1:
        print ">> GET CONFIG"
    
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
        print confdir + ": NOT EXIST"
        return

    # generate list of files
    f = open(srclist, 'w') 

    for item_dir in srcdir:
	if not os.path.isdir(item_dir):
	    continue
	gv_writelist(f, item_dir);

    f.close()

def gv_gentags():
    if debug == 1:
        print ">> GEN TAGS"

    global global_config

    confdir = global_config['CONF_DIR']
    confdir = dir_trim(confdir)
    srclist = confdir + "project.files"

    if not os.path.isfile(srclist):
	print srclist + " NOT EXIST"
	return 

    ctagsfile = global_config['CTAGS_FILE']
    cmd = "ctags -V --c-kinds=+p --c++-kinds=+p --fields=+iaSl --extra=+q " + \
	  " -o " + ctagsfile +  " -L " + srclist
    os.system(cmd)

def gv_settags():
    if debug == 1:
        print ">> SET TAGS"
    
    global global_config

    ctagsfile = global_config['CTAGS_FILE']
    if not os.path.isfile(ctagsfile):
        print "CTAGS FILE: " + ctagsfile + " -> Not exist!"
        return

    # I don't know, why the command must be a variable
    # If it is not a variable, command will not run properly
    cmd = "set tags=" + ctagsfile   
    print cmd
    vim.command(cmd)

def gv_updatetags():
    if debug == 1:
        print ">> UDPATE TAGS"
    gv_gentags()
    gv_settags()

def gv_gencscope():
    global global_config

    confdir = global_config['CONF_DIR']
    confdir = dir_trim(confdir)
    srclist  = confdir + "project.files"
    cscopeout = confdir + "cscope.out"

    if not os.path.isfile(srclist):
	print srclist + " NOT EXIST"
	return 

    # generate cscope database
    cmd = "cscope -b -k -v "

    # if on Linux add reverse database
    if platform.system() == 'Linux':
        cmd += " -q "

    cmd += "-i " + srclist + " -f " + cscopeout
    os.system(cmd)

def gv_addcscope():
    global global_config

    cscopedb = global_config['CSCOPE_DB']
    if os.path.isfile(cscopedb):
        cmd = "cs add " + cscopedb
        vim.command(cmd)
    else:
        print "CSCOPE DB FILE NOT EXIST"

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

def gv_load(prjconf=".gvproj/prj.conf"):
    if not os.path.isfile(prjconf):
        print prjconf + ": NOT EXIST!"
        return

    gv_getconfig(prjconf)
    gv_settags()
    gv_addcscope()
    #gv_loadlist()

def gv_init(prjconf=".gvproj/prj.conf"):
    if not os.path.isfile(prjconf):
        print prjconf + ": NOT EXIST!"
        return

    gv_getconfig(prjconf) 
    gv_collectsrc()
    #gv_loadlist()
    gv_gentags()
    gv_gencscope()
    gv_settags()
    gv_addcscope()

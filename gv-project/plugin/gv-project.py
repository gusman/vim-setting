import vim
import os

def dir_trim(str):
        if '/' != str[len(str) - 1]:
                str = str + '/'
        return str

def str_trim(str):
        if '\n' == str[len(str) - 1]:
                str = str[:-1]
        return str


# create/check project directory
def create_projdir():
        src_dir = vim.eval('g:gv_srcdir')
        new_dir = src_dir + '/gv_project'
        
        if not os.path.isdir(new_dir):
                os.mkdir(new_dir)

        vim.command("let g:gv_projdir = '" + new_dir + "'")

# create/check project file
def create_projfile():
        proj_path = vim.eval("g:gv_projdir")
        file_path = proj_path + '/project.info'
        print file_path

        # Create the file
        f = open(file_path, "w")

        # Update vim global variable for project file path
        vim.command("let g:gv_projfile = '" + file_path + "'")

# create/check macrolist file
def create_macrolistfile():
        proj_path = vim.eval("g:gv_projdir")
        file_path = proj_path + '/macrolist'
        print file_path
        
        # Create the file
        f = open(file_path, "w")
        
        #Update vim global variable for macro list file path
        vim.command("let g:gv_macrolist = '" + file_path + "'")

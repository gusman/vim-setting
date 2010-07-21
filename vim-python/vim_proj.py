import vim

def py_input(msg = 'input'):
        vim.command('call inputsave()')
        vim.command("let user_input = inputdialog('" + msg + ":')")
        vim.command('call inputrestore()')
        return vim.eval('user_input')

def dir_trim(str):
        if '/' != str[len(str) - 1]:
                str = str + '/'
        return str

def str_trim(str):
        if '\n' == str[len(str) - 1]:
                str = str[:-1]
        return str

def gen_and_set_tags(proj_file):
        # Open file
        f = open(proj_file, "r")

        # Get project file path
        f.seek(13)
        tmp_str = f.readline()
        tmp_str = str_trim(tmp_str)
        project_file = tmp_str

        # Get tag file path
        f.seek(9,1)
        tmp_str = f.readline()
        tmp_str = str_trim(tmp_str)
        tag_file = tmp_str

        # Get source dir
        f.seek(8,1)
        tmp_str = f.readline()
        tmp_str = str_trim(tmp_str)
        src_dir = tmp_str

        # Close file
        f.flush()
        f.close()

        # Set the commands
        cmd_gen_tags = "!ctags -R -f " + tag_file + " " + src_dir + "/*"
        cmd_set_tags = "set tags=" + tag_file

        print cmd_gen_tags
        print cmd_set_tags

        # Execute the commands
        vim.command(cmd_gen_tags)
        vim.command(cmd_set_tags)

def gen_proj_file():
        proj_dir  = py_input("proj dir")
        proj_file = py_input("proj file")
        tag_file  = py_input("tag file")
        src_dir   = py_input("src_dir")

        proj_dir = dir_trim(proj_dir)
        f = open(proj_dir +  proj_file, "w")

        f.write("project-file=" + proj_dir + proj_file + '\n')
        f.write("tag-file=" + proj_dir + tag_file + '\n')
        f.write("src-dir=" + src_dir + '\n')

        f.flush()
        f.close()

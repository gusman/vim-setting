#!/usr/bin/python

from Config import FileConfig

class Project(FileConfig):
	def __init__(self, filename):
		FileConfig.__init__(self, filename)

	def gen_ctags(self):
		pass

	def gen_csope(self):
		pass

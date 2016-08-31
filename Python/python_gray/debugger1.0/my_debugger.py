from ctypes import *
from my_debugger_defines import *
kernel32=windll.kernel32
class debugger(object):
	def __init__(self):
		pass

	def load(self,path_to_exe):
		"""
		dwCreation flag determines how to create the process
		set creation_flags=CREATE_NEW_CONSOLE if you want to see the calculator GUI
		"""
		creation_flags=DEBUG_PROCESS
		#creation_flags=CREATE_NEW_CONSOLE
		
		#instantiate the structs
		startupinfo=STARTUPINFO()
		process_information=PROCESS_INFORMATION()
		
		"""
		The following two options allow the started process to be shown as 
		a separate window.This also illustrates how different settings in the
		STARTUPINFO struct can affect the debugger.
		"""
		startupinfo.dwFlags=0x1
		startupinfo.wShowWindow=0x0

		"""
		We then initialize the cb variable in the STARTUPINFO struct
		which is just the size of the struct itself
		"""
		startupinfo.cb=sizeof(startupinfo)

		if kernel32.CreateProcessA(
			path_to_exe,
			None,
			None,
			None,
			None,
			creation_flags,
			None,
			None,
			byref(startupinfo),
			byref(process_information)
			):
			print '[*] We habe successfully launched the process!'
			print '[*] PID:%d' % process_information.dwProcessId
		else:
			print '[*] Error:0x%08x.' % kernel32.GetLastError()
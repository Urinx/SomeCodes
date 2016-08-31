from ctypes import *
msvcrt=cdll.msvcrt
"""
or
msvcrt=CDLL('msvcrt.dll')
"""
message_string="Hello world!\n"
msvcrt.wprintf('Testing:%s',message_string)
input('')
import my_debugger
debugger=my_debugger.debugger()
pid=raw_input('Enter the PID of the process to attach to:')
debugger.attach(int(pid))
thlist=debugger.enumerate_threads()
"""
For each thread in the list we want to
grab the value of each of the registers
"""
for thread in thlist:
	thread_context=debugger.get_thread_context(thread)
	#Now let's output the contents of some of the registers
	print '[*] Dumping registers for thread ID:0x%08x' % thread
	print '[*] EIP:0x%08x' % thread_context.Eip
	print '[*] ESP:0x%08x' % thread_context.Esp
	print '[*] EBP:0x%08x' % thread_context.Ebp
	print '[*] EAX:0x%08x' % thread_context.Eax
	print '[*] EBX:0x%08x' % thread_context.Ebx
	print '[*] ECX:0x%08x' % thread_context.Ecx
	print '[*] EDX:0x%08x' % thread_context.Edx
	print '[*] END DUMP'
debugger.detach()
#! /usr/bin/env python

isa=isinstance
Symbol=str

class Env(dict):

    def __init__(self, parms=(), args=(), outer=None):
        # Bind parm list to corresponding args, or single parm to list of args
        self.outer = outer
        if isa(parms, Symbol): 
            self.update({parms:list(args)})
        else: 
            if len(args) != len(parms):
                raise TypeError('expected %s, given %s, ' 
                                % (to_string(parms), to_string(args)))
            self.update(zip(parms,args))

    def find(self, var):
        "Find the innermost Env where var appears."
        if var in self: return self
        elif self.outer is None: raise LookupError(var)
        else: return self.outer.find(var)
		
def add_globals(env):
	import math, operator as op
	env.update(vars(math))
	env.update({
		'+':op.add, '-':op.sub, '*':op.mul, '/':op.div, 'not':op.not_,
    	'>':op.gt, '<':op.lt, '>=':op.ge, '<=':op.le, '=':op.eq, 
    	'equal?':op.eq, 'eq?':op.is_, 'length':len, 'cons':lambda x,y:[x]+y,
    	'car':lambda x:x[0],'cdr':lambda x:x[1:], 'append':op.add,  
    	'list':lambda *x:list(x), 'list?': lambda x:isa(x,list), 
    	'null?':lambda x:x==[], 'symbol?':lambda x: isa(x, Symbol)
		})
	return env

global_env=add_globals(Env())

#==========================================#

def tokenize(program):
	return [i for i in program.replace('(',' ( ').replace(')',' ) ').split(' ') if i]

def parse(program):
	return read_tokens(tokenize(program))

def read_tokens(tokens):
	if len(tokens)==0:
		raise SyntaxError('unexpected EOF while reading')
	token=tokens.pop(0)
	if '('==token:
		L=[]
		while tokens[0]!=')':
			L.append(read_tokens(tokens))
		tokens.pop(0) # pop off ')'
		return L
	elif ')'==token:
		raise SyntaxError('unexpected )')
	else:
		return atom(token)

def atom(token):
	try:
		return int(token)
	except Exception:
		try:
			return float(token)
		except Exception:
			return Symbol(token)

def eval(x,env=global_env):
	if isa(x,Symbol):			# variable reference
		return env.find(x)[x]
	elif not isa(x,list):		# constant literal
		return x
	elif x[0]=='quote':			# (quote exp)
		(_,exp)=x
		return exp
	elif x[0]=='if':			# (if test conseq alt)
		(_,test,conseq,alt)=x
		return eval((conseq if eval(test,env) else alt),env)
	elif x[0]=='set!':			# (set! var exp)
		(_,var,exp)=x
		env.find(var)[var]=eval(exp,env)
	elif x[0]=='define':		# (define var exp)
		(_,var,exp)=x
		env[var]=eval(exp,env)
	elif x[0]=='lambda':		# (lambda (var*) exp)
		(_,vars,exp)=x
		return lambda *args:eval(exp,Env(vars,args,env))
	elif x[0]=='begin':			# (begin exp*)
		for exp in x[1:]:
			val=eval(exp,env)
		return val
	else:						# (proc exp*)
		exps=[eval(exp,env) for exp in x]
		proc=exps.pop(0)
		return proc(*exps)

def repl(prompt='>> '):
	banner()
	while 1:
		program=raw_input(prompt)
		if program:
			if program=='(quit)' or program=='(exit)':
				quit()
				break
			elif program=='(help)':
				help()
				continue
			val=eval(parse(program))
			if val is not None: print to_string(val)

def to_string(exp):
	return '('+' '.join(map(to_string, exp))+')' if isa(exp, list) else str(exp)

def banner():
	print 'Lis.py -1.0.0 -17 Oct 2014'
	print 'Welcome to Lis.py!'
	print 'This is an interpreter for a small subset of the Scheme'
	print 'programming language written entirely in Python.'
	print 'Enter (help) for more information.'

def help():
	print 'Lip.py Help'
	print '==========='
	print 'Welcome to Lis.py!'
	print 'This is an interpreter for a small subset of the Scheme programming'
	print 'language written entirely in Python. Edited by Uri.'
	print 'Usage:'
	print '(help) :for help'
	print '(quit) or (exit) :to quit the lisp interpreter'

def quit():
	print 'Exit the interpreter...'

if __name__ == '__main__':
	repl()
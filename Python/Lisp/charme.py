###
### Chapter 11: Interpreters
### Charme Interpreter Code
###
### David Evans, March 2009
### Updated for cs1120 Fall 2009, ps7
###
### You should modify this file to answer the questions
### for PS7.  For some of the questions, write your
### answers at the beginning of this file.  For others,
### you will need to find the right places to modify
### in the provided code:
###
###
### Name(s):
###
### Email ID(s):

authors = ['*** your id here ***', '*** partner id here if partner ***']

### Question 1:

question1 = """
    <answer>
"""

### Question 2:

charmeFactorialDefinition = "<your code here>"

### Questions 3-8:
### Modify the provided interpreter code below

### Question 9:

pleased = """
Replace this with text explaining what you are most pleased about this course.
"""

displeased = """ 
Replace this with text explaining what you are most displeased about this course.
"""

hopetolearn = """
Replace this with text explaining what specific things you hope to learn in the remainder of the course.
"""

###
### Charme Interpreter
### This is the code from Chapter 11 of the course book.
###
    
def tokenize(s):
    current = '' 
    tokens = [] 
    for c in s: 
        if c.isspace(): 
            if len(current) > 0: 
                tokens.append(current)
                current = '' 
        elif c in '()': 
            if len(current) > 0: 
                tokens.append(current)
                current = ''
            tokens.append(c) 
        else: 
            current = current + c 
    
    if len(current) > 0: 
        tokens.append(current)
    return tokens 

def parse(s):
    def parsetokens(tokens, inner):
       res = []
       while len(tokens) > 0:
          current = tokens.pop(0)
          if current == '(':
             res.append (parsetokens(tokens, True))
          elif current == ')':
             if inner:
                return res
             else:
                error('Unmatched close paren: ' + s)
                return None
          else:
             res.append(current)
        
       if inner:
          error ('Unmatched open paren: ' + s)
          return None
       else:
          return res

    return parsetokens(tokenize(s), False)

###
### Evaluator
###

def meval(expr, env):
    if isPrimitive(expr):
       return evalPrimitive(expr)
    elif isIf(expr):             
        return evalIf(expr, env) 
    elif isDefinition(expr):                
       evalDefinition(expr, env)
    elif isName(expr):
       return evalName(expr, env)
    elif isLambda(expr):
       return evalLambda(expr, env)
    elif isApplication(expr):
       return evalApplication(expr, env)
    else:
       error ('Unknown expression type: ' + str(expr))

### Primitives

def isPrimitive(expr):
    return (isNumber(expr) or isPrimitiveProcedure(expr))

def isNumber(expr):
    return isinstance(expr, str) and expr.isdigit()

def evalPrimitive(expr):
    if isNumber(expr):
        return int(expr)
    else:
        return expr

def isPrimitiveProcedure(expr):
    return callable(expr)

def primitivePlus (operands):
    if (len(operands) == 0):
       return 0
    else:
       return operands[0] + primitivePlus (operands[1:])

def primitiveTimes (operands):
    if (len(operands) == 0):
       return 1
    else:
       return operands[0] * primitiveTimes (operands[1:])
    
def primitiveMinus (operands):
    if (len(operands) == 1):
       return -1 * operands[0]
    elif len(operands) == 2:
       return operands[0] - operands[1]
    else:
       evalError('- expects 1 or 2 operands, given %s: %s' % (len(operands), str(operands)))

def primitiveEquals (operands):
    checkOperands (operands, 2, '=')
    return operands[0] == operands[1]

def primitiveZero (operands):
    checkOperands (operands, 1, 'zero?')
    return operands[0] == 0

def primitiveGreater (operands):
    checkOperands (operands, 2, '>')
    return operands[0] > operands[1]

def primitiveLessThan (operands):
    checkOperands (operands, 2, '<')
    return operands[0] < operands[1]

def checkOperands(operands, num, prim):
    if (len(operands) != num):
       evalError('Primitive %s expected %s operands, given %s: %s' 
                 % (prim, num, len(operands), str(operands)))

### Special Forms
       
def isSpecialForm(expr, keyword):
    return isinstance(expr, list) and len(expr) > 0 and expr[0] == keyword

def isIf(expr):
    return isSpecialForm(expr, 'if')

def evalIf(expr,env):
    assert isIf(expr)
    if len(expr) != 4:
        evalError ('Bad if expression: %s' % str(expr))
    if meval(expr[1], env) != False:
        return meval(expr[2],env)
    else:
        return meval(expr[3],env)

### Definitions and Names

class Environment:
    def __init__(self, parent):
        self._parent = parent
        self._frame = {}
    def addVariable(self, name, value):
        self._frame[name] = value
    def lookupVariable(self, name):
        if self._frame.has_key(name):
            return self._frame[name]
        elif (self._parent):
            return self._parent.lookupVariable(name)
        else:
            evalError('Undefined name: %s' % (name))

def isDefinition(expr):
    return isSpecialForm(expr, 'define')

def evalDefinition(expr, env):
    assert isDefinition(expr)
    if len(expr) != 3:
        evalError ('Bad definition: %s' % str(expr))
    name = expr[1]
    if isinstance(name, str):
        value = meval(expr[2], env)
        env.addVariable(name, value)
    else:
        evalError ('Bad definition: %s' % str(expr))

def isName(expr):
    return isinstance(expr, str)

def evalName(expr, env):
    assert isName(expr)
    return env.lookupVariable(expr)

### Procedures

class Procedure:
    def __init__(self, params, body, env):
        self._params = params
        self._body = body
        self._env = env
    def getParams(self):
        return self._params
    def getBody(self):
        return self._body
    def getEnvironment(self):
        return self._env        
    def __str__(self):
        return '<Procedure %s / %s>' % (str(self._params), str(self._body))

def isLambda(expr):
    return isSpecialForm(expr, 'lambda')

def evalLambda(expr,env):
    assert isLambda(expr)
    if len(expr) != 3:
        evalError ('Bad lambda expression: %s' % str(expr))
    return Procedure(expr[1], expr[2], env)

### Applications
                   
def isApplication(expr): # requires: all special forms checked first
    return isinstance(expr, list)
   
def evalApplication(expr, env):
    subexprs = expr
    subexprvals = map (lambda sexpr: meval(sexpr, env), subexprs)
    return mapply(subexprvals[0], subexprvals[1:])

def mapply(proc, operands):
    if (isPrimitiveProcedure(proc)):
        return proc(operands)
    elif isinstance(proc, Procedure):
        params = proc.getParams()
        newenv = Environment(proc.getEnvironment())
        if len(params) != len(operands):
            evalError ('Parameter length mismatch: %s given operands %s' 
                       % (str(proc), str(operands)))
        for i in range(0, len(params)):
               newenv.addVariable(params[i], operands[i])        
        return meval(proc.getBody(), newenv)        
    else:
        evalError('Application of non-procedure: %s' % (proc))

### Eval-Loop

def initializeGlobalEnvironment():
    global globalEnvironment
    globalEnvironment = Environment(None)
    globalEnvironment.addVariable('true', True)
    globalEnvironment.addVariable('false', False)
    globalEnvironment.addVariable('+', primitivePlus)
    globalEnvironment.addVariable('-', primitiveMinus)
    globalEnvironment.addVariable('*', primitiveTimes)
    globalEnvironment.addVariable('=', primitiveEquals)
    globalEnvironment.addVariable('zero?', primitiveZero)
    globalEnvironment.addVariable('>', primitiveGreater)
    globalEnvironment.addVariable('<', primitiveLessThan)

def evalError(msg): # not in book
    print "Error: " + msg    

def parseError(msg): # not in book
    print "Parse Error: " + msg    

def evalLoop():
    initializeGlobalEnvironment()
    while True:
        inv = raw_input('Charme> ')
        if inv == 'quit': break
        for expr in parse(inv):
            print str(meval(expr, globalEnvironment))

def evalInGlobal(expr):
    return meval(parse(expr)[0], globalEnvironment)


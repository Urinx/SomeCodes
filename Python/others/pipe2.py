class Pipe(object):
    def __init__(self, func):
        self.func = func

    def __ror__(self, left):
        if left is not None:
            if type(left) is list:
                return [self.func(i) for i in left]
            else:
                return self.func(left)

class Redirect(object):
    def __init__(self, func):
        self.func = func
        self.value = None

    def __ror__(self, left):
        if left is not None:
            if type(left) is list:
                [self.func(i) for i in left]
            else:
                self.func(left)
        self.value = left
        return self

    def __gt__(self, right):
        # '>'
        with open(right, 'w+') as f:
            if self.value is not None:
                for line in self.value:
                    f.write(line + '\n')

    def __rshift__(self, right):
        # '>>'
        with open(right, 'a+') as f:
            if self.value is not None:
                for line in self.value:
                    f.write(line + '\n')

    def __lt__(self, left):
        # '<'
        with open(left, 'r') as f:
            return [line.strip() for line in f]

@Pipe
def double(n):
    return 2*n

@Pipe
def to_string(n):
    return str(n)

@Redirect
def echo(a):
    print a

@Redirect
def read():
    pass

nums = [1,2,3,4,5,6,7,8,9]
nums | double | to_string | echo > '1.txt'
('1.txt' > read) | echo

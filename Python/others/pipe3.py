class PipeData(object):
    def __init__(self, data):
        self.data = data

    def __or__(self, func):
        self.data = [func(i) for i in self.data]
        return self

    def __gt__(self, right):
        with open(right, 'w+') as f:
            if self.data is not None:
                for line in self.data:
                    f.write(line + '\n')

def double(n):
    return 2*n

def echo(n):
    print n
    return n

num = [1,2,3,4,5,6,7,8,9]
nump = PipeData(num)
nump | double | str | echo > '2.txt'

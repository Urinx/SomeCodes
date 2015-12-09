#!/usr/bin/env python

# Token types
#
# EOF (end-of-file) token is used to indicate that 
# there is no more input left for lexical analysis

INTEGER, PLUS, MINUS, WHITESPACE, EOF = 'INTEGER', 'PLUS', 'MINUS', 'WHITESPACE', 'EOF'

class Token(object):
   def __init__(self, type, value):
      # token type: INTEGER, PLUS, MINUS, WHITESPACE or EOF
      self.type = type
      # token value: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, '+', '-', ' ' or None
      self.value = value

   def __str__(self):
      """String representation of the class instance.
      
      Excamples:
         Token(INTEGER, 3)
         Token(PLUS, '+')
      """
      return 'Token({type}, {value})'.format(
            type = self.type,
            value = repr(self.value)
      )

   def __repr__(self):
      return self.__str__()

class Interpreter(object):
   def __init__(self, text):
      # client string input, e.g. "3+5"
      self.text = text
      # self.pos is an index into self.text
      self.pos = 0
      # current token instance
      self.current_token = None

   def error(self):
      raise Exception('Error parsing input')

   def get_next_token(self):
      """Lexical analyzer (also known as scanner or tokenizer)

      This method is responsible for breaking a sentence
      apart into tokens. One token at a time.
      """
      text = self.text

      # is self.pos index past the end of the self.text ?
      # if so, then return EOF token bacause there is no more
      # inout left to convert into tokens
      if self.pos > len(text) - 1:
         return Token(EOF, None)

      # get a character at the position and decide what
      # token to create based on the single character
      current_char = text[self.pos]

      # if the character is a digit then convert it to
      # integer, create an INTEGER token, increment self.pos
      # index to point to the next character after the digit,
      # and return the INTEGER token
      if current_char.isdigit():
         token = Token(INTEGER, current_char)
         self.pos += 1
         return token

      if current_char == '+':
         token = Token(PLUS, current_char)
         self.pos += 1
         return token

      if current_char == '-':
         token = Token(MINUS, current_char)
         self.pos += 1
         return token
      
      if current_char.isspace():
         token = Token(WHITESPACE, ' ')
         self.pos += 1
         return token

      self.error()

   def eat(self, token_type):
      # compare the current token type with the passed token
      # type and if they match then "eat" the current token
      # and assign the next token to the self.current_token,
      # otherwise raise an exception.
      if self.current_token.type == token_type:
         self.current_token = self.get_next_token()
      else:
         self.error()

   def expr(self):
      """expr -> INTEGER PLUS INTEGER"""
      # set current token to the first token taken from the input
      self.current_token = self.get_next_token()

      left, right, i = [], [], 1
      while self.current_token.type != EOF:
         if self.current_token.type == INTEGER:
            if i: left.append(self.current_token.value)
            else: right.append(self.current_token.value)
         elif self.current_token.type in [PLUS, MINUS]:
            op = self.current_token
            i = 0
         self.current_token = self.get_next_token()

      # at this point INTEGER PLUS INTEGER sequence of tokens
      # has been successfully found and the method can just
      # return the result of adding teo integers, thus
      # effectively interpreting client input
      left = int(''.join(left))
      right = int(''.join(right))
      if op.type == PLUS:
         result = left + right
      elif op.type == MINUS:
         result = left - right
      return result

def main():
   while True:
      try:
         text = raw_input('calc> ')
      except EOFError:
         print "\n[quit]: EOF"
         break
      except KeyboardInterrupt:
         print "\n[quit]: Keyboard Interrupt"
         break
      except:
         print "\n[quit]"
         break
      if not text:
         continue
      interpreter = Interpreter(text)
      result = interpreter.expr()
      print result

if __name__ == '__main__':
   main()

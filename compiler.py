# imports
import sys

# constants

# variables
look = None
_input = ""
_idx = 0

# helpers
def _getChar():
    look = _input[_idx]
    _idx+1

def _isAlpha():
    ord('a') <= ord(look) <= ord('z')

def _isNum():
    ord('0') <= ord(look) <= ord('9')

def _expect(val):
    _abort(val + ' Expected')

def _abort(val):
    raise Exception(val)

def _match(val):
    if look == val:
        _getChar()
    else:
        _expect(val)

# -----------------------
# math parsers/translators

def _ident():
    'handles identifiers'
    pass

def _factor():
    'handles factors'
    pass

def _term():
    'handles terms'
    pass

def _add():
    'handles add'
    pass

def _subtract():
    'handles subtract'
    pass

def _multiply():
    'handles multiply'
    pass

def _divide():
    'handles divide'
    pass

def _expression():
    pass

# -----------------------

def _init():
    _getChar()

def main(input_string):
    _input = input_string
    _init()
    _expression()

for line in sys.stdin:
    print(line)
    main(line.rstrip())

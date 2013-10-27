import icc.atp

def _debug(*args):
    print "Printing:", args, [type(o) for o in args]
    return False

def _print(*args):
    for a in args:
        print a,

def nl():
    print

def _add(a, b):
    print "add", a, b
    return a + b

def _mul(a, b):
    print "mult"
    return a * b;

icc.atp.hello_func('PPP111')

icc.atp.symb('atom', 'print', 1, _print)
icc.atp.symb('atom', 'nl', 0, nl)
icc.atp.symb('atom', 'debug', 1, _debug)
icc.atp.symb('const', 'c1', 0, 1)
icc.atp.symb('const', 'c2', 0, 2)
icc.atp.symb('func', '+', 2, _add)
icc.atp.symb('func', '*', 2, _mul)

#icc.atp.atp_annote('../../../submodules/prisnif/problems/john_boy', '15', 'w')
print "Now sum test."
icc.atp.atp_annote('../../../submodules/prisnif/problems/testar-pr', '15', 'w')
quit()

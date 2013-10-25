#!/bin/env python2
from icc.atp.atp import *

def atp_annote(*args):
    rc=run(*args)
    if rc==0:
        print "Result of refutation is SUCCESS, i.e., REFUTED."
    else:
        print ("Result is: %d" % rc) + ',i.e., it is NOT REFUTED.'
    return rc

if __name__=="__main__":
    import sys
    atp_annote(sys.argv[1], sys.argv[2], sys.argv[3])
    quit()

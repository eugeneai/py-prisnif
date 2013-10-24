#!/bin/env python2
import icc.atp.atp as a

if __name__=="__main__":
    import sys
    rc=a.run(sys.argv[1], sys.argv[2], sys.argv[3])
    print "Result is:", rc
    quit()

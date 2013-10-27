import icc.atp

def _print(**args):
        print "Printing:", args


icc.atp.hello_func('PPP')
icc.atp.symb('atom', 'print', 1, _print)
icc.atp.atp_annote('../../../submodules/prisnif/problems/john_boy', '15', 'w')
quit()

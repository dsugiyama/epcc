import sys
import commands
import re
import itertools

niter = int(sys.argv[1])
mic = sys.argv[2]
cmd = " ".join(sys.argv[4:])

iter_cmd = "for i in `seq %d`; do %s; done" % (niter, cmd)
ssh_cmd = "ssh %s -- '. .profile; cd tmp; %s'" % (mic, iter_cmd)

output = commands.getoutput(ssh_cmd)
matches = re.finditer(r"(.+) overhead = ([0-9\.]+)", output)
tuples = [(m.group(1), float(m.group(2))) for m in matches]
keyfunc = lambda t: t[0]
results = itertools.groupby(sorted(tuples, key=keyfunc), keyfunc)

for k, g in results:
    l = [t[1] for t in g]
    print k + ": " + str(sum(l) / len(l))

nth="240 480 960"

bench=$1
niter=$2
mic=$3

for n in $nth; do
    echo "Intel"
    python aggregate.py $niter $mic -- \
        OMP_NUM_THREADS=$n ./$bench-intel
    echo

    echo "Omni (Pthread)"
    python aggregate.py $niter $mic -- \
        OMP_NUM_THREADS=$n ./$bench-omni
    echo

    echo "Omni (Argobots)"
    python aggregate.py $niter $mic -- \
        OMPC_NUM_PROCS=240 OMPC_NUM_FORK=$n ./$bench-abt
    echo
done

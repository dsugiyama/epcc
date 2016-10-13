nth="64 256"

bench=$1
niter=$2
part=$3

for n in $nth; do
    echo "Intel"
    srun -p $part -- python aggregate.py $niter -- \
        OMP_NUM_THREADS=$n ./$bench-intel
    echo

    echo "Omni-Argobots"
    srun -p $part -- python aggregate.py $niter -- \
        OMP_NUM_THREADS=$n OMPC_NUM_PROCS=$n ./$bench-abt
    echo

    echo "BOLT"
    srun -p $part -- python aggregate.py $niter -- \
        OMP_NUM_THREADS=$n OMP_THREAD_LIMIT=$n ./$bench-bolt
    echo
done

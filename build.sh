if (($# != 1)); then
    exit 1
fi

for defs in Makefile.defs.{intel,omni,abt}; do
    cp $defs Makefile.defs
    make $1
    mv $1 $1-${defs##*.}
    make clean
done

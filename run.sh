#!/bin/bash

A=100

for C in 5 10 15; do

    for d in 0.05 0.1 0.15; do

	D=`echo "$A * $C * $d" | bc | awk -F. '{print $1}'`

	for E in 5 10 15; do

	    for f in 0.05 0.1 0.15; do

		F=`echo "$D * $E * $f" | bc | awk -F. '{print $1}'`

		for G in 1 5 10; do
		
		    for h in 0.1 0.15 0.25; do

			H=`echo "$F * $G * $h" | bc | awk -F. '{print $1}'`

			# create temp script
			cat template.xml \
			    | sed "s/[[C]]/$C/g" \
			    | sed "s/[[D]]/$D/g" \
			    | sed "s/[[E]]/$E/g" \
			    | sed "s/[[F]]/$F/g" \
			    | sed "s/[[G]]/$G/g" \
			    | sed "s/[[H]]/$H/g" >> temp.xml

			cp -r template_dir working_dir
			cd working_dir

			/usr/bin/time -f "%U" timeout 1h mpirun -n 12 multistage_rosetta_scripts.mpiserialization.linuxgccrelease @ flags

			cd ../
			rm -rf working_dir

		    done

		done

	    done #F

	done #E
	
    done #D

done #C

#!/bin/bash

A=100

if [ -f _results ]; then
    echo "Will not overwrite existing _results file" 1>&2
    exit 1
fi

#echo $A $C $d $D $E $f $F $G $h $H $x $mean_score >> _results
echo "NTRAJ C d D E f F G h H num_designs mean_score" > _results

for C in 5 10 15; do

    for d in 0.05 0.1 0.15; do

	D=`echo "$A * $C * $d" | bc | awk -F. '{print $1}'`
	if [[ ${#D} -eq "0" ]]; then
	    continue;
	elif [[ $D -eq 0 ]]; then
	    continue;
	fi

	for E in 5 10 15; do

	    for f in 0.05 0.1 0.15; do

		F=`echo "$D * $E * $f" | bc | awk -F. '{print $1}'`
		if [[ ${#F} -eq "0" ]]; then
		    continue;
		elif [[ $F -eq 0 ]]; then
		    continue;
		fi


		for G in 1 5 10; do
		
		    for h in 0.1 0.15 0.25; do

			H=`echo "$F * $G * $h" | bc | awk -F. '{print $1}'`
			#echo $F $G $h `echo "$F * $G * $h" | bc` $H
			if [[ ${#H} -eq "0" ]]; then
			    continue;
			elif [[ $H -eq 0 ]]; then
			    continue;
			fi

			# create temp script
			cat template.xml \
			    | sed "s/##C##/$C/g" \
			    | sed "s/##D##/$D/g" \
			    | sed "s/##E##/$E/g" \
			    | sed "s/##F##/$F/g" \
			    | sed "s/##G##/$G/g" \
			    | sed "s/##H##/$H/g" >> temp.xml

			#exit 0

			cp -r template_dir working_dir
			cd working_dir

			#RUN
			#/usr/bin/time -f "%U"
			#Let's not use /usr/bin/time and just to time counting internally
			timeout 1h mpirun -n 12 multistage_rosetta_scripts.mpiserialization.linuxgccrelease @ ../flags

			cat score.sc >> ../all_scores.sc

			#ANALYZE
			for x in 1 5 10 25 50 100; do
			    mean_score=$(awk -v c1=MS_weighted -f ../print_column_no_header.awk score.sc \
					     | sort -nk1 | head -n $x | awk -f ../average.awk
				      )
			    echo $A $C $d $D $E $f $F $G $h $H $x $mean_score >> ../_results
			done

			cd ../
			rm -rf working_dir

		    done

		done

	    done #F

	done #E
	
    done #D

done #C

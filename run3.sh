#!/bin/bash

# Variables:
# <Stage num_runs_per_input_struct="##A##" total_num_results_to_keep="1">
#         <Add mover_name="virt"/>
#         <Add mover_name="root"/>
#         Sort filter="weighted_motif"/>
#         <Sort filter="true_filter"/>
# </Stage>
# <Stage num_runs_per_input_struct="##C##" total_num_results_to_keep="##D##">
#         <Add mover_name="t1"/>
#         <Add mover_name="chim"/>
#         <Add mover_name="t2"/>
#         <Sort filter="weighted_motif"/>
# </Stage>
# <Stage num_runs_per_input_struct="##E##" total_num_results_to_keep="##F##">
#         <Add mover_name="t3"/>
#         <Add mover_name="shear_move_gsa"/>
#         <Add mover_name="t4"/>
#         <Sort filter="weighted_motif"/>
# </Stage>
# <Stage num_runs_per_input_struct="##G##" total_num_results_to_keep="##H##">
#         <Add mover_name="t5"/>
#         <Add mover_name="small_move_gsa"/>
#         <Add mover_name="t6"/>
#         <Sort filter="weighted_motif"/>
# </Stage>

A=500 #number of trajectories
time_limit="5h"

if [ -f _results ]; then
    echo "Will not overwrite existing _results file" 1>&2
    exit 1
fi

#echo $A $C $d $D $E $f $F $G $h $H $x $mean_score >> _results
echo "NTRAJ C d D E f F G h H num_designs mean_score" > _results

for C in 8 10 13; do #centered on 10

    for d in 0.03 0.05 0.08; do # centered on 0.05

	D=`echo "$A * $C * $d" | bc | awk -F. '{print $1}'`
	if [[ ${#D} -eq "0" ]]; then
	    continue;
	elif [[ $D -eq 0 ]]; then
	    continue;
	fi

	for E in 3 5 8; do #centered on 5

	    for f in 0.03 0.05 0.08; do # centered on 0.05

		F=`echo "$D * $E * $f" | bc | awk -F. '{print $1}'`
		if [[ ${#F} -eq "0" ]]; then
		    continue;
		elif [[ $F -eq 0 ]]; then
		    continue;
		fi

		for G in 3 5 8; do #centered on 5

		H=$A

		    #for h in 0.08 0.1 0.13; do # centered on 0.1

			#H=`echo "$F * $G * $h" | bc | awk -F. '{print $1}'`

			#if [[ ${#H} -eq "0" ]]; then
			#    continue;
			#elif [[ $H -eq 0 ]]; then
			#    continue;
			#fi

			# create temp script
		cat template.xml \
		    | sed "s/##A##/$A/g" \
		    | sed "s/##C##/$C/g" \
		    | sed "s/##D##/$D/g" \
		    | sed "s/##E##/$E/g" \
		    | sed "s/##F##/$F/g" \
		    | sed "s/##G##/$G/g" \
		    | sed "s/##H##/$H/g" > temp.xml

		#exit 0

		cp -r template_dir working_dir
		cd working_dir

		#RUN
		#/usr/bin/time -f "%U"
		#Let's not use /usr/bin/time and just to time counting internally
		echo Running $A $C $d $D $E $f $F $G $h $H `date`
		timeout $time_limit mpirun -n 12 multistage_rosetta_scripts.mpiserialization.linuxgccrelease @ flags

		cat score.sc >> ../all_scores.sc

		#ANALYZE
		for x in 1 5 10 25 50 100; do
		    if [[ `grep vav1_start_node_and_partner score.sc | wc -l` -ge $x ]]; then
			mean_score=$(awk -v c1=MS_weighted -f ../print_column_no_header.awk score.sc \
					 | sort -nk1 | head -n $x | awk -f ../average.awk
				  )
			echo $A $C $d $D $E $f $F $G $h $H $x $mean_score >> ../_results
		    fi
		done

		cd ../
		rm -rf working_dir

		   #done

		done

	    done #F

	done #E

    done #D

done #C

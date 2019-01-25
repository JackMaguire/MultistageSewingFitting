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

if [ -f _results.run2 ]; then
    echo "Will not overwrite existing _results.run2 file" 1>&2
    exit 1
fi

A=1000 #number of trajectories
time_limit="10h"

echo "NTRAJ C d D E f F G h H num_designs mean_score" > _results.run2

#1
C=5; d=0.05; E=5; f=0.1; G=1; h=0.15; token=1
D=`echo "$A * $C * $d" | bc | awk -F. '{print $1}'`
if [[ ${#D} -eq "0" ]] || [[ $D -eq 0 ]]; then
    #do nothing
else
	F=`echo "$D * $E * $f" | bc | awk -F. '{print $1}'`
	if [[ ${#F} -eq "0" ]] || [[ $F -eq 0 ]]; then
		#do nothing
	else	
		H=`echo "$F * $G * $h" | bc | awk -F. '{print $1}'`
		if [[ ${#H} -eq "0" ]] || [[ $H -eq 0 ]]; then
			#do nothing
		else
			#Hot Loop!
			cat template.xml \
				| sed "s/##A##/$A/g" \
				| sed "s/##C##/$C/g" \
				| sed "s/##D##/$D/g" \
				| sed "s/##E##/$E/g" \
				| sed "s/##F##/$F/g" \
				| sed "s/##G##/$G/g" \
				| sed "s/##H##/$H/g" > temp.xml
				
			cp -r template_dir working_dir
			cd working_dir

			#RUN
			echo Running $A $C $d $D $E $f $F $G $h $H `date`
			timeout $time_limit mpirun -n 12 multistage_rosetta_scripts.mpiserialization.linuxgccrelease @ flags

			cat score.sc >> ../all_scores.run2.sc

			#ANALYZE
			for x in 1 5 10 25 50 100; do
			    if [[ `grep vav1_start_node_and_partner score.sc | wc -l` -ge $x ]]; then
				mean_score=$(awk -v c1=MS_weighted -f ../print_column_no_header.awk score.sc \
						 | sort -nk1 | head -n $x | awk -f ../average.awk
					  )
				echo $A $C $d $D $E $f $F $G $h $H $x $mean_score >> ../_results.run2
			    fi
			done

			cd ../
			rm -rf working_dir

		fi
	fi #F
fi #D

C=5; d=0.05; E=5; f=0.05; G=5; h=0.15; token=2
C=10; d=0.05; E=5; f=0.05; G=1; h=0.25; token=3
C=5; d=0.05; E=10; f=0.15; G=5; h=0.1; token=4
C=10; d=0.05; E=10; f=0.1; G=10; h=0.15; token=5
C=5; d=0.1; E=15; f=0.15; G=5; h=0.15; token=6
C=5; d=0.15; E=10; f=0.05; G=10; h=0.25; token=7
C=10; d=0.1; E=5; f=0.15; G=1; h=0.25; token=8
C=5; d=0.1; E=5; f=0.05; G=10; h=0.25; token=9
C=10; d=0.05; E=5; f=0.05; G=5; h=0.1; token=10
C=10; d=0.05; E=5; f=0.15; G=1; h=0.15; token=11
C=5; d=0.1; E=5; f=0.05; G=10; h=0.15; token=12



#echo $A $C $d $D $E $f $F $G $h $H $x $mean_score >> _results



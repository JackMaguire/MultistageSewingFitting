#!/bin/bash
stage1=$(grep vav all_scores.sc | awk '{print $30 - $24 }' | awk -f average.awk)
stage2=$(grep vav all_scores.sc | awk '{print $32 - $31 }' | awk -f average.awk)
stage3=$(grep vav all_scores.sc | awk '{print $34 - $33 }' | awk -f average.awk)
stage4=$(grep vav all_scores.sc | awk '{print $36 - $35 }' | awk -f average.awk)
stage5=$(grep vav all_scores.sc | awk '{print $14 - $37 }' | awk -f average.awk)
stage6=$(grep vav all_scores.sc | awk '{print $16 - $15 }' | awk -f average.awk)
stage7=$(grep vav all_scores.sc | awk '{print $18 - $17 }' | awk -f average.awk)
stage8=$(grep vav all_scores.sc | awk '{print $20 - $19 }' | awk -f average.awk)
stage9=$(grep vav all_scores.sc | awk '{print $22 - $21 }' | awk -f average.awk)
stage10=$(grep vav all_scores.sc | awk '{print $25 - $23 }' | awk -f average.awk)
stage11=$(grep vav all_scores.sc | awk '{print $27 - $26 }' | awk -f average.awk)
stage12=$(grep vav all_scores.sc | awk '{print $29 - $28 }' | awk -f average.awk)

echo $stage1 $stage2 $stage3 $stage4 $stage5 $stage6 $stage7 $stage8 $stage9 $stage10 $stage11 $stage12


grep -v NTRAJ _results | while read line; do
  total_minutes=0.0
  n_traj=`echo $line | awk '{print $1}'`
  C=`echo $line | awk '{print $2}'`
  D=`echo $line | awk '{print $4}'`
  E=`echo $line | awk '{print $5}'`
  F=`echo $line | awk '{print $7}'`
  G=`echo $line | awk '{print $8}'`
  H=`echo $line | awk '{print $10}'`
  
  #stage 1
  n_stage_1=$(echo "$n_traj * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage1 * $n_stage_1 )" | bc -l)
  total_minutes=$total_minutes_temp

  #stage 2
  n_stage_2=$(echo "$D * $E" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage2 * $n_stage_2 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 3
  n_stage_3=$(echo "$F * $G" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage3 * $n_stage_3 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 4
  n_stage_4=$(echo "$H * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage4 * $n_stage_4 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 5
  n_stage_5=$(echo "$D * $E" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage5 * $n_stage_5 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 6
  n_stage_6=$(echo "$H * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage6 * $n_stage_6 )" | bc -l)
  total_minutes=$total_minutes_temp

  #stage 7
  n_stage_7=$(echo "$H * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage7 * $n_stage_7 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 8
  n_stage_8=$(echo "$D * $E" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage8 * $n_stage_8 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 9
  n_stage_9=$(echo "$H * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage9 * $n_stage_9 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 10
  n_stage_10=$(echo "$H * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage10 * $n_stage_10 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 11
  n_stage_11=$(echo "$D * $E" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage11 * $n_stage_11 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  #stage 12
  n_stage_12=$(echo "$H * $C" | bc -l)
  total_minutes_temp=$(echo "$total_minutes + ( $stage12 * $n_stage_12 )" | bc -l)
  total_minutes=$total_minutes_temp
  
  echo $total_minutes
done

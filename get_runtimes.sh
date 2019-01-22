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

#!/bin/bash

set -e

RESULT_DIR="/dss/dsshome1/0D/ru47tac2/projects/segrap2025/lukas.greipel@campus.lmu.de/Task01_results"

declare -A mapping=(
  [0001]=0120
  [0002]=0121
  [0003]=0122
  [0004]=0123
  [0005]=0124
  [0006]=0125
  [0007]=0126
  [0008]=0127
  [0009]=0128
  [0010]=0129
  [0011]=0130
  [0012]=0131
  [0013]=0132
  [0014]=0133
  [0015]=0134
  [0016]=0135
  [0017]=0136
  [0018]=0137
  [0019]=0138
  [0020]=0139
)

cd "$RESULT_DIR"

for old_id in "${!mapping[@]}"; do
  new_id=${mapping[$old_id]}
  old_file="SegRap_${old_id}.nii.gz"
  new_file="SegRap_${new_id}.nii.gz"
  
  if [[ -f "$old_file" ]]; then
    echo "🔄 Renaming $old_file → $new_file"
    mv "$old_file" "$new_file"
  else
    echo "⚠️  File not found: $old_file"
  fi
done

echo "✅ Umbenennung abgeschlossen."

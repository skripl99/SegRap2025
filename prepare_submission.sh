#!/bin/bash

# Zielstruktur
TEAM_NAME="lukas.greipel@campus.lmu.de"
TASK_DIR="${TEAM_NAME}/Task01_results"
mkdir -p "$TASK_DIR"

# Quelle: Alle Vorhersagen außer Bild 14
SOURCE_ALL="/dss/dsshome1/0D/ru47tac2/projects/segrap2025/predictions_ensemble"
find "$SOURCE_ALL" -type f -name 'SegRap_*.nii.gz' ! -name 'SegRap_0014.nii.gz' -exec cp {} "$TASK_DIR" \;

# Quelle: Bild 14 aus Einzel-Inferenz
SOURCE_14="/dss/dsshome1/0D/ru47tac2/projects/segrap2025/tmp_output_single14"
cp "$SOURCE_14/SegRap_0014.nii.gz" "$TASK_DIR"

# Alles zippen
zip -r "${TEAM_NAME}_Task01_submission.zip" "$TEAM_NAME"

echo "✅ Submission ZIP erstellt: ${TEAM_NAME}_Task01_submission.zip"

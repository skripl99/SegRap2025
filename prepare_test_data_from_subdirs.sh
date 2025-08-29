#!/bin/bash

# Quell- und Zielverzeichnisse
SOURCE_DIR="/dss/dsshome1/0D/ru47tac2/projects/segrap2025/validation_data/team_name/Task01_results"
TARGET_DIR="/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnUNet_raw_data_base/nnUNet_raw_data/Dataset201_SegRap2025Task1/imagesTs"

# Zielverzeichnis erstellen
mkdir -p "$TARGET_DIR"

# Alle Unterordner durchgehen (SegRap_XXXX)
for case_dir in "$SOURCE_DIR"/SegRap_*; do
    if [[ -d "$case_dir" ]]; then
        case_id=$(basename "$case_dir")
        input_file="$case_dir/imaging.nii.gz"
        output_file="$TARGET_DIR/${case_id}_0000.nii.gz"

        if [[ -f "$input_file" ]]; then
            cp "$input_file" "$output_file"
            echo "✔️  Kopiert: $case_id -> ${case_id}_0000.nii.gz"
        else
            echo "⚠️  WARNUNG: Keine Datei gefunden für $case_id"
        fi
    fi
done

echo "✅ Alle Daten erfolgreich in $TARGET_DIR umgewandelt."

#!/bin/bash
#SBATCH --job-name=nnunet_single_14
#SBATCH --output=logs/single_predict_%j.out
#SBATCH --error=logs/single_predict_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --partition=mcml-dgx-a100-40x8
#SBATCH --qos=mcml

set -e
set -x

source ~/.bashrc
conda activate nnunetv2

export nnUNet_raw=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnUNet_raw_data_base/nnUNet_raw_data
export nnUNet_preprocessed=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_preprocessed
export nnUNet_results=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_results

IMAGES_TS=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnUNet_raw_data_base/nnUNet_raw_data/Dataset201_SegRap2025Task1/imagesTs
TEMP_STORAGE=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/tmp_moved_away_images
OUTPUT_DIR=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/tmp_output_single14

# Lege Temp-Verzeichnis an
mkdir -p "$TEMP_STORAGE"
mkdir -p "$OUTPUT_DIR"

# Verschiebe alle außer Bild 14 temporär raus
find "$IMAGES_TS" -type f ! -name "SegRap_0014_0000.nii.gz" -exec mv {} "$TEMP_STORAGE" \;

# Starte Vorhersage
nnUNetv2_predict \
  -i "$IMAGES_TS" \
  -o "$OUTPUT_DIR" \
  -d 201 \
  -c 3d_fullres \
  -f all

# Bilder zurückschieben
mv "$TEMP_STORAGE"/* "$IMAGES_TS"
rmdir "$TEMP_STORAGE"

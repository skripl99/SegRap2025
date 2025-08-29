#!/bin/bash
#SBATCH --job-name=nnunet_ensemble_val
#SBATCH --output=logs/nnunet_ensemble_val_%j.out
#SBATCH --error=logs/nnunet_ensemble_val_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --partition=mcml-dgx-a100-40x8
#SBATCH --qos=mcml

set -e
set -x

source ~/.bashrc
conda activate nnunetv2

# Setze Umgebungsvariablen
export nnUNet_raw=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnUNet_raw_data_base/nnUNet_raw_data
export nnUNet_preprocessed=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_preprocessed
export nnUNet_results=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_results

# Neue Eingabe: umgewandelte Testbilder in imagesTs
INPUT_DIR=$nnUNet_raw/Dataset201_SegRap2025Task1/imagesTs
OUTPUT_DIR=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/predictions_ensemble

# Starte Ensemble-Inferenz mit allen 5 Folds
nnUNetv2_predict \
  -d 201 \
  -c 3d_fullres \
  -f all \
  -i "$INPUT_DIR" \
  -o "$OUTPUT_DIR" \
  --save_probabilities
#!/bin/bash
#SBATCH --job-name=postproc_f4
#SBATCH --output=logs/nnunet_postproc_f4_%j.out
#SBATCH --error=logs/nnunet_postproc_f4_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --partition=mcml-dgx-a100-40x8
#SBATCH --qos=mcml

set -e
set -x

source ~/.bashrc
conda activate nnunetv2

# Setze Umgebungsvariablen (Pfad ggf. anpassen)
export nnUNet_raw=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnUNet_raw_data_base/nnUNet_raw_data
export nnUNet_preprocessed=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_preprocessed
export nnUNet_results=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_results

# Führe Postprocessing auf Fold 4 durch
nnUNetv2_find_best_configuration 201 -c 3d_fullres -f 4

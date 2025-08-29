#!/bin/bash
#SBATCH --job-name=nnunet_train
#SBATCH --output=logs/nnunet_train_%j.out
#SBATCH --error=logs/nnunet_train_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=48:00:00
#SBATCH --partition=mcml-dgx-a100-40x8
#SBATCH --qos=mcml

set -e
set -x

source ~/.bashrc
conda activate nnunetv2

# Falls nötig: Pfade explizit setzen
export nnUNet_raw=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnUNet_raw_data_base/nnUNet_raw_data
export nnUNet_preprocessed=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_preprocessed
export nnUNet_results=/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_results

# Starte Training für alle 5 folds (0-4)
nnUNetv2_train 201 3d_fullres all \
  > logs/train_stdout_$SLURM_JOB_ID.log \
  2> logs/train_stderr_$SLURM_JOB_ID.log

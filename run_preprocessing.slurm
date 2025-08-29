#!/bin/bash
#SBATCH --job-name=nnunet_preproc
#SBATCH --output=logs/nnunet_preproc_%j.out
#SBATCH --error=logs/nnunet_preproc_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --partition=mcml-dgx-a100-40x8
#SBATCH --qos=mcml

set -e
set -x

source /dss/dsshome1/0D/ru47tac2/miniconda3/etc/profile.d/conda.sh
conda init
conda activate nnunetv2

nnUNetv2_plan_and_preprocess -d 201 -c 3d_fullres -np 1 --verify_dataset_integrity \

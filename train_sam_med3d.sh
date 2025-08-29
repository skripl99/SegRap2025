#!/bin/bash
#SBATCH --job-name=sam3d_train
#SBATCH --output=logs/sam3d_%j.out
#SBATCH --error=logs/sam3d_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --partition=mcml-dgx-a100-40x8
#SBATCH --qos=mcml

source ~/.bashrc
conda activate sammed3d

cd ~/projects/segrap2025/SAM-Med3D/

python train.py \
  --task_name segrap2025task1 \
  --work_dir results \
  --checkpoint ckpt/sam_med3d_turbo.pth \
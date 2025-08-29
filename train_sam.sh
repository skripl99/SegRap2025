#!/bin/bash
#SBATCH --job-name=sam3d_train
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --output=sam3d_train.out

# Lade Conda und aktiviere deine Umgebung
source ~/miniconda3/etc/profile.d/conda.sh
conda activate sam3d

# Starte Training
cd ~/projects/segrap2025/SAM-Med3D
python train.py --config ../configs/segrap2025.yaml

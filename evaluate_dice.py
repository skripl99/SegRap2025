import os
import nibabel as nib
import numpy as np
from medpy.metric import binary

prediction_dir = "/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_results/Dataset201_SegRap2025Task1/nnUNetTrainer__nnUNetPlans__3d_fullres/fold_all/validation"
gt_dir = "/dss/dsshome1/0D/ru47tac2/projects/segrap2025/nnunet_data/nnUNet_preprocessed/Dataset201_SegRap2025Task1/gt_segmentations"

for fname in os.listdir(prediction_dir):
    if not fname.endswith(".nii.gz"):
        continue

    pred = nib.load(os.path.join(prediction_dir, fname)).get_fdata().astype(np.uint8)
    gt = nib.load(os.path.join(gt_dir, fname)).get_fdata().astype(np.uint8)

    print(f"\nCase: {fname}")
    for cls in [1, 2, 3]:
        pred_bin = (pred == cls).astype(np.uint8)
        gt_bin = (gt == cls).astype(np.uint8)
        if np.sum(gt_bin) == 0 and np.sum(pred_bin) == 0:
            dice = 1.0
        elif np.sum(gt_bin) == 0 or np.sum(pred_bin) == 0:
            dice = 0.0
        else:
            dice = binary.dc(pred_bin, gt_bin)
        print(f"  Dice class {cls}: {dice:.4f}")

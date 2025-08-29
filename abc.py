import SimpleITK as sitk
import os

input_dir = "/dss/dsshome1/0D/ru47tac2/projects/segrap2025/validation_data/team_name/Task01_results"
for fname in sorted(os.listdir(input_dir)):
    if fname.endswith(".nii.gz"):
        try:
            img = sitk.ReadImage(os.path.join(input_dir, fname))
            print(f"{fname}: OK — shape: {img.GetSize()}, spacing: {img.GetSpacing()}")
        except Exception as e:
            print(f"{fname}: ERROR -> {e}")

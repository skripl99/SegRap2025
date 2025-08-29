import nibabel as nib
import numpy as np
import os

label_dir = 'nnUNet_raw_data_base/nnUNet_raw_data/Dataset201_SegRap2025Task1/labelsTr'
for fname in os.listdir(label_dir):
    if fname.endswith('.nii.gz'):
        fpath = os.path.join(label_dir, fname)
        img = nib.load(fpath)
        data = img.get_fdata()

        if data.dtype != np.uint8:
            print(f"Fixing {fname} (was {data.dtype})")
            img_uint8 = nib.Nifti1Image(data.astype(np.uint8), img.affine, img.header)
            img_uint8.set_data_dtype(np.uint8)
            nib.save(img_uint8, fpath)

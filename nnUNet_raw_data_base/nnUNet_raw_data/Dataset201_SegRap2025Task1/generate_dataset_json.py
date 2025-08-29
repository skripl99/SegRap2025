import os
import json

# === Pfade anpassen falls nötig ===
imagesTr_dir = "./imagesTr"
labelsTr_dir = "./labelsTr"
output_file = "dataset.json"

# === Metadaten anpassen ===
dataset = {
    "name": "SegRap2025Task1",
    "description": "Segmentation of two tumor targets in 3D CT volumes",
    "tensorImageSize": "4D",
    "modality": {
        "0": "CT"
    },
    "labels": {
        "0": "background",
        "1": "target1",
        "2": "target2"
    },
    "channel_names": {
        "0": "CT"
    },
    "file_ending": ".nii.gz",
}

# === Dateinamen sammeln ===
image_files = sorted([f for f in os.listdir(imagesTr_dir) if f.endswith(".nii.gz")])
label_files = sorted([f for f in os.listdir(labelsTr_dir) if f.endswith(".nii.gz")])

# === Konsistenz check ===
assert len(image_files) == len(label_files), "Unterschiedliche Anzahl Bild- und Label-Dateien"

# === Trainingsliste aufbauen ===
dataset["numTraining"] = len(image_files)
dataset["training"] = []

for img, lbl in zip(image_files, label_files):
    img_path = f"./imagesTr/{img}"
    lbl_path = f"./labelsTr/{lbl}"
    dataset["training"].append({"image": img_path, "label": lbl_path})

# === Kein Testset ===
dataset["numTest"] = 0

# === Speichern ===
with open(output_file, "w") as f:
    json.dump(dataset, f, indent=2)

print(f"Wrote dataset.json with {len(image_files)} training cases.")

import os

# Backend must be set BEFORE importing keras
os.environ["KERAS_BACKEND"] = "torch"

import torch

# Verify hardware visibility
cuda_ready = torch.cuda.is_available()
print(f"CUDA Available: {cuda_ready}")

if cuda_ready:
    print(f"GPU: {torch.cuda.get_device_name(0)}")
    print(f"Device Count: {torch.cuda.device_count()}")
else:
    print("\n[!] GPU not found. Check drivers or CUDA installation.")

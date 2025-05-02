# GPU Matrix Multiplication Kernel & Profiler

Raw CUDA naive and shared-memory tiled kernels with a cuBLAS timing harness and independently validated CPU references.

This is newly generated educational reference code based on a concept in the supplied PDF.
It has **165 non-empty source, test, configuration, workload and documentation files**.
It is a prototype for study and extension, not evidence of previous deployment or measured large-scale performance.

## Quick start

Requires Python 3.10+ and NumPy (`python -m pip install -r requirements.txt`).

```sh
python scripts/demo.py
python scripts/run_tests.py
python scripts/benchmark.py
python scripts/serve.py --port 8080
```

Open http://127.0.0.1:8080 for the workload dashboard. `scripts/demo.py --case workloads/<id>.case.json`
executes one workload and checks its independent acceptance conditions. `benchmark.py` prints actual local timings.

## Implemented scope

Runnable Python CPU oracles, compiled C++ CPU baseline, raw naive CUDA kernel, 16x16 shared-memory CUDA kernel, CUDA-event timing and cuBLAS comparison source.

## Limits and optional runtimes

CUDA, cuBLAS, CMake and Nsight are not available in the generation environment. GPU sources are uncompiled and unexecuted here. Python tile32 is a CPU workload; only tile16 is provided in CUDA. No GPU speedup, memory-throughput or transformer-scale claim. cuBLAS may select hardware-specific math paths.

All bundled data are synthetic. No credentials, pretrained model weights, historical commits, or fabricated benchmark results are included.
See `docs/PROVENANCE.md`, `docs/TESTING.md`, and the bundle's validation report for evidence and omissions.

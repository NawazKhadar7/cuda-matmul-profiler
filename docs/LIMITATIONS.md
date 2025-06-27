# Limitations

CUDA, cuBLAS, CMake and Nsight are not available in the generation environment. GPU sources are uncompiled and unexecuted here. Python tile32 is a CPU workload; only tile16 is provided in CUDA. No GPU speedup, memory-throughput or transformer-scale claim. cuBLAS may select hardware-specific math paths.

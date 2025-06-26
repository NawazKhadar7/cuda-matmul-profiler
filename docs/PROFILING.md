# Profiling plan

After correctness passes, run `ncu ./build/cuda_benchmark 1024` and inspect occupancy, shared-memory throughput and global access efficiency. Record device, toolkit, clocks and error tolerance. Profile separate kernels; Python timing does not describe GPU performance.

# Algorithms

Naive kernel assigns one output element per thread. Tiled kernel loads A/B blocks into shared memory, synchronizes, accumulates products and zero-pads tail tiles. Row-major cuBLAS uses C^T=B^T A^T by swapping operands. Reference: https://docs.nvidia.com/cuda/cuda-c-programming-guide/ and https://docs.nvidia.com/cuda/cublas/ .

#pragma once
#include <vector>
#include <stdexcept>
inline std::vector<float> cpu_matmul(const std::vector<float>& a,const std::vector<float>& b,int m,int k,int n){
    if(m<1||k<1||n<1||a.size()!=static_cast<size_t>(m*k)||b.size()!=static_cast<size_t>(k*n))throw std::invalid_argument("shape mismatch");
    std::vector<float> c(static_cast<size_t>(m*n),0);
    for(int i=0;i<m;++i)for(int j=0;j<n;++j)for(int p=0;p<k;++p)c[i*n+j]+=a[i*k+p]*b[p*n+j];
    return c;
}
#ifdef __CUDACC__
#include <cuda_runtime.h>
void launch_naive(const float*,const float*,float*,int,int,int,cudaStream_t);
void launch_tiled(const float*,const float*,float*,int,int,int,cudaStream_t);
#endif

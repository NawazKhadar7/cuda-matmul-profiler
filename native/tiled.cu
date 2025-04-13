#include "matmul.hpp"
template<int TILE> __global__ void tiled_kernel(const float*a,const float*b,float*c,int m,int k,int n){
    __shared__ float as[TILE][TILE],bs[TILE][TILE];
    const int row=blockIdx.y*TILE+threadIdx.y,col=blockIdx.x*TILE+threadIdx.x;float sum=0;
    for(int base=0;base<k;base+=TILE){
        const int ak=base+threadIdx.x,bk=base+threadIdx.y;
        as[threadIdx.y][threadIdx.x]=(row<m&&ak<k)?a[row*k+ak]:0;
        bs[threadIdx.y][threadIdx.x]=(bk<k&&col<n)?b[bk*n+col]:0;
        __syncthreads();
        #pragma unroll
        for(int p=0;p<TILE;++p)sum+=as[threadIdx.y][p]*bs[p][threadIdx.x];
        __syncthreads();
    }
    if(row<m&&col<n)c[row*n+col]=sum;
}
void launch_tiled(const float*a,const float*b,float*c,int m,int k,int n,cudaStream_t stream){
    tiled_kernel<16><<<dim3((n+15)/16,(m+15)/16),dim3(16,16),0,stream>>>(a,b,c,m,k,n);
}

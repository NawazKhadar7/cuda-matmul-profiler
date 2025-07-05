#include "matmul.hpp"
__global__ void naive_kernel(const float*a,const float*b,float*c,int m,int k,int n){
    const int row=blockIdx.y*blockDim.y+threadIdx.y,col=blockIdx.x*blockDim.x+threadIdx.x;
    if(row>=m||col>=n)return;float sum=0;
    for(int p=0;p<k;++p)sum+=a[row*k+p]*b[p*n+col];c[row*n+col]=sum;
}
void launch_naive(const float*a,const float*b,float*c,int m,int k,int n,cudaStream_t stream){
    naive_kernel<<<dim3((n+15)/16,(m+15)/16),dim3(16,16),0,stream>>>(a,b,c,m,k,n);
}

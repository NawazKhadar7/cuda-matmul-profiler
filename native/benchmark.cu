#include "matmul.hpp"
#include <cublas_v2.h>
#include <iostream>
#include <chrono>
#include <cmath>
#include <algorithm>
#include <cstdlib>
static void cuda_check(cudaError_t value){if(value!=cudaSuccess)throw std::runtime_error(cudaGetErrorString(value));}
static void blas_check(cublasStatus_t value){if(value!=CUBLAS_STATUS_SUCCESS)throw std::runtime_error("cuBLAS failure");}
int main(int argc,char**argv){
    try{
        int n=argc>1?std::stoi(argv[1]):128;if(n<1||n>2048)throw std::invalid_argument("n outside 1..2048");
        std::vector<float>a(n*n),b(n*n),out(n*n);
        for(int i=0;i<n*n;++i){a[i]=(i%17-8)*.01f;b[i]=(i%13-6)*.01f;}
        const auto expected=cpu_matmul(a,b,n,n,n);float *da=nullptr,*db=nullptr,*dc=nullptr;
        cuda_check(cudaMalloc(&da,n*n*sizeof(float)));cuda_check(cudaMalloc(&db,n*n*sizeof(float)));cuda_check(cudaMalloc(&dc,n*n*sizeof(float)));
        cuda_check(cudaMemcpy(da,a.data(),n*n*sizeof(float),cudaMemcpyHostToDevice));cuda_check(cudaMemcpy(db,b.data(),n*n*sizeof(float),cudaMemcpyHostToDevice));
        cudaEvent_t start,stop;cuda_check(cudaEventCreate(&start));cuda_check(cudaEventCreate(&stop));cublasHandle_t handle;blas_check(cublasCreate(&handle));
        for(int mode=0;mode<3;++mode){
            auto run=[&](){if(mode==0)launch_naive(da,db,dc,n,n,n,0);else if(mode==1)launch_tiled(da,db,dc,n,n,n,0);else{float alpha=1,beta=0;blas_check(cublasSgemm(handle,CUBLAS_OP_N,CUBLAS_OP_N,n,n,n,&alpha,db,n,da,n,&beta,dc,n));}cuda_check(cudaGetLastError());};
            run();cuda_check(cudaDeviceSynchronize());cuda_check(cudaEventRecord(start));for(int repeat=0;repeat<10;++repeat)run();cuda_check(cudaEventRecord(stop));cuda_check(cudaEventSynchronize(stop));float ms;cuda_check(cudaEventElapsedTime(&ms,start,stop));
            cuda_check(cudaMemcpy(out.data(),dc,n*n*sizeof(float),cudaMemcpyDeviceToHost));float error=0;for(int i=0;i<n*n;++i)error=std::max(error,std::fabs(out[i]-expected[i]));
            std::cout<<"{\"method\":\""<<(mode==0?"naive":mode==1?"tiled16":"cublas")<<"\",\"n\":"<<n<<",\"mean_kernel_ms\":"<<ms/10<<",\"max_error\":"<<error<<"}"<<std::endl;
            if(error>1e-3f)throw std::runtime_error("correctness tolerance exceeded");
        }
        cublasDestroy(handle);cudaEventDestroy(start);cudaEventDestroy(stop);cudaFree(da);cudaFree(db);cudaFree(dc);return 0;
    }catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}
}

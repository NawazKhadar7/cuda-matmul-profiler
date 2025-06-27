#include "matmul.hpp"
#include <iostream>
#include <cmath>
int main(){
    std::vector<float>a{1,2,3,4,5,6},b{7,8,9,10,11,12};auto c=cpu_matmul(a,b,2,3,2);
    const float expected[]={58,64,139,154};float error=0;
    for(int i=0;i<4;++i)error=std::max(error,std::fabs(c[i]-expected[i]));
    std::cout<<"{\"max_error\":"<<error<<",\"cpu_compiled\":true}"<<std::endl;return error>1e-5?1:0;
}

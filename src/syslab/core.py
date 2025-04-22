import numpy as np
from .common import validate_case
from .matrices import naive,tiled
FAMILIES=('naive','tile16','tile32','rectangular','edges','batched')
def run_case(case):
    validate_case(case)
    if case['family'] not in FAMILIES:raise ValueError('unknown matrix family')
    n=case['size'];family=case['family'];rng=np.random.default_rng(case['seed']);m=n+3 if family=='edges' else n;k=n+5 if family=='rectangular' else n;columns=max(1,n//2) if family=='rectangular' else n;batch=3 if family=='batched' else 1;errors=[];shapes=[]
    for _ in range(batch):
        a=rng.normal(size=(m,k));b=rng.normal(size=(k,columns));expected=a@b
        actual=naive(a,b) if family=='naive' else tiled(a,b,32 if family=='tile32' else 16)
        errors.append(float(np.max(np.abs(actual-expected))));shapes.append(list(actual.shape))
    return {'metrics':{'size':n,'batches':batch,'max_absolute_error':max(errors),'correct':max(errors)<1e-9,'gpu_executed':False,'scalar_products':batch*m*k*columns},'output':{'shapes':shapes,'execution':'CPU reference; raw CUDA sources require NVIDIA runtime'}}

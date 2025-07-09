import numpy as np

def naive(a,b):
    if a.ndim!=2 or b.ndim!=2 or a.shape[1]!=b.shape[0]:raise ValueError('matmul shape mismatch')
    out=np.zeros((a.shape[0],b.shape[1]),dtype=float)
    for i in range(a.shape[0]):
        for j in range(b.shape[1]):
            for k in range(a.shape[1]):out[i,j]+=a[i,k]*b[k,j]
    return out

def tiled(a,b,tile=16):
    if tile<1 or a.ndim!=2 or b.ndim!=2 or a.shape[1]!=b.shape[0]:raise ValueError('invalid tiled matmul')
    out=np.zeros((a.shape[0],b.shape[1]))
    for i in range(0,a.shape[0],tile):
        for j in range(0,b.shape[1],tile):
            for k in range(0,a.shape[1],tile):out[i:i+tile,j:j+tile]+=a[i:i+tile,k:k+tile]@b[k:k+tile,j:j+tile]
    return out

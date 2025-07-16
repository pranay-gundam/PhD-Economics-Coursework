import numpy as np
import matplotlib.pyplot as plt

# Two things I have left are I need to make the graphing and I need to evaluate the integrals properly
# in both Q and p, right now they aren't integrating with respect to a distribution, in this case since
# stuff is all uniform it's ok but that may not always be the case. More specifically, I need to sample
# points from the "discretized space" in a manner similar to how the e and w distributions are and then divide
# by the total number of samples. This conceptually is fine but in practice isn't at all a trivial task.
#   (1) Can sample a point in the space and just choose the closest discrete point
#   (2) Can use the np.sample function and give it some distribution

beta = 0.95
B = 10
b = B/4
D = B/2

wdiscretize = 0.1
ediscretize = 0.1

wmin = 0
wmax = B

emin = 0
emax = D

WstateSpace = np.arange(wmin, wmax+wdiscretize, wdiscretize)
EstateSpace = np.arange(emin, emax+ediscretize, ediscretize)

stateSpace = np.array([np.array([(WstateSpace[i], EstateSpace[j]) for j in range(len(EstateSpace))]) for i in range(len(WstateSpace))])
valueSpace_init = np.zeros(shape=np.size(stateSpace))

# 0 means reject offer, 1 means accept offer
policySpace_init = np.zeros(shape=np.size(stateSpace))

def Q(valueSpace, stateSpace):
    wsize = np.size(stateSpace)[0]
    esize = np.size(stateSpace)[1]
    N = wsize * esize
    qsum = 0
    for i in range(wsize):
        for j in range(esize):
            qsum += valueSpace[i,j][0]
    return qsum / N

def p(w_index, valueSpace, stateSpace):
    esize = np.size(stateSpace)[1]
    psum = 0
    for j in range(esize):
        qsum += valueSpace[w_index,j][0]
    return psum / esize

def value(windex, eindex, b, 
          valueSpace_prev = valueSpace_init, 
          policySpace_prev = policySpace_init, 
          stateSpace = stateSpace):
    
    w,e = stateSpace[windex, eindex]
    accept = w - e + beta*p(windex, valueSpace_prev, stateSpace)
    reject = b + beta * Q(valueSpace_prev, stateSpace)
    
    if accept >= reject:
        valueSpace_prev[windex, eindex] = accept
        policySpace_prev[windex, eindex] = 1
    else:
        valueSpace_prev[windex, eindex] = reject
        policySpace_prev[windex, eindex] = 0
    
    return valueSpace_prev, policySpace_prev

def totalUpdate(b,
                valueSpace_prev = valueSpace_init, 
                policySpace_prev = policySpace_init, 
                stateSpace = stateSpace):
    wsize = np.size(stateSpace)[0]
    esize = np.size(stateSpace)[1]

    for i in range(wsize):
        for j in range(esize):
            valueSpace_prev, policySpace_prev = value(i,j,b,valueSpace_prev, policySpace_prev)

    return valueSpace_prev, policySpace_prev


def mainLoop(iters, b):
    for i in range(iters):
        if i == 0:
            finVals, finPols = totalUpdate(b)
        else:
            finVals, finPols = totalUpdate(b, finVals, finPols)
    
    return finVals, finPols
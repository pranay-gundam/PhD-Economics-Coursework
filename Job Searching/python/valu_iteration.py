import numpy as np

def ValueIteration(valInitFunc, searchSpace_MinMaxInt, searchSpace):
    if searchSpace == []:
        searchSpace = [np.linspace(searchSpace_MinMaxInt[i][0], 
                                   searchSpace_MinMaxInt[i][1], 
                                   searchSpace_MinMaxInt[i][2]) for i in range(len(searchSpace_MinMaxInt))]

    valueSpace = []
    




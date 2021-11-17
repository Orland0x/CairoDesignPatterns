import numpy as np 

#take one array and produce another using only recursion. python reference

def fill_array(content, new_array, offset):

    if offset == len(content): 
        print(new_array)
        return new_array 
    new_array[offset] = content[offset] + 7
    fill_array(content, new_array, offset+1)

out = fill_array(np.array([1,2,3]),np.zeros(3), 0)
print(out)


# a = np.zeros(3)
# print(a)
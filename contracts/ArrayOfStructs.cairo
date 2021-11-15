%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (signed_div_rem, sign, assert_nn)
from starkware.cairo.common.math_cmp import is_le

#Cairo does not currently allow an array of structs to be passed to a function in the calldata. We demonstrate here with 2 structs but it can be trivially generalized. 

struct T:
	member mem1 : felt
	member mem2 : felt 
end 


#Option 1: Passing one array as A = [T1.mem1, T1.mem2, T2.mem1, T2.mem2]
#The array pointer is cast to a struct T pointer, incrememnted by the size of T then cast again for the second struct. 
@view 
func acceptArray1 {range_check_ptr} (
		arr_len : felt, 
		arr : felt*
	) -> (
		out : felt
	):
	#check that the array provided is a multiple of the size of the struct
	let num_structs = arr_len / T.SIZE 
	assert_nn(num_structs)

	#shift pointer by the size of T so that temp points to the start of t2
	tempvar temp = arr + T.SIZE

	#Cast arr, which is a felt pointer, to a pointer to a struct T 
	let t1 = cast(arr,T*)
	let t2 = cast(temp,T*)

	#demo operation
	tempvar out = t1.mem1 + t1.mem2 + t2.mem1 + t2.mem2
	return (out)
end 

#Option 2: Pass multiple arrays each one containing an array of values for a certain value in the struct. A1 = [T1.mem1, T2.mem1] A2 = [T1.mem2, T2.mem2]. 
#Then build structs back together within the function
@view 
func acceptArray2 {range_check_ptr} (
		mem1_len : felt, 
		mem1 : felt*,
		mem2_len : felt, 
		mem2 : felt* 
	) -> (
		out : felt
	): 
	assert mem1_len = mem2_len 

	tempvar t1 : T = T([mem1],[mem2])
	tempvar t2_mem1 = mem1 + 1
	tempvar t2_mem2 = mem2 + 1
	tempvar t2 : T = T([t2_mem1], [t2_mem2])

	tempvar out = t1.mem1 + t1.mem2 + t2.mem1 + t2.mem2 
	return (out)
end

#In general, Option1 seems superior as less writing to temporary variables is required. It is slightly faster also when tested. 




%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (signed_div_rem, sign, assert_nn)
from starkware.cairo.common.math_cmp import is_le
from starkware.cairo.common.registers import get_fp_and_pc
from starkware.cairo.common.alloc import alloc

#procedure to populate an array from another array 

#use 15 puzzle for reference. 

#In wrapper function:
#assign local variables for content and array 
#store frame pointer (fp) for this frame so these arrays can be accessed 

#Now call the recursive function, passing a reference to content and array, along with the end condition 

@external 
func fill_array_wrapper {range_check_ptr} (
        content_len : felt,
        content : felt*
    ) -> (
        array_len : felt,
        array : felt*
    ):
    alloc_locals

    let (local array : felt*) = alloc()

    #let (__fp__, _) = get_fp_and_pc() #contract compiles with or without this line, think its only required if one needs to access local variable locations via &var

    let array_len = content_len
    fill_array(content_len, content, array_len, array)



    return (array_len, array) 

end       

@view
func fill_array {range_check_ptr} (
        content_len : felt, 
        content : felt*,
        array_len : felt,
        array : felt*
    ):

    if content_len == 0:
        return ()
    end

    assert array[array_len-content_len] = content[0] + 1

    fill_array(content_len-1, content+1, array_len, array)


    return ()

end


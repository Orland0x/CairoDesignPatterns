%lang starknet
%builtins pedersen range_check bitwise

from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import ( unsigned_div_rem, assert_nn_le)
from starkware.cairo.common.bitwise import bitwise_and

#exploring packing felts with mutiple smaller values to minimize the number of storage slots used by a contract 

const DIV_100 = 2**100
const DIV_50 = 2**50
const DIV_25 = 2**25


#Constants for 2 packing
const MAX_2 = 2**125 #the largest number that can be packed (can be set larger than this)

const SHIFT_2_1 = 2**125

const MASK_2_0 = 2**125 - 1 
const MASK_2_1 = 2**250 - 2**125 


#Constants for 5 packing 
const MAX_5 = 2**50 

const SHIFT_5_1 = 2**50 
const SHIFT_5_2 = 2**100 
const SHIFT_5_3 = 2**150 
const SHIFT_5_4 = 2**200 

const MASK_5_0 = 2**50 - 1 
const MASK_5_1 = 2**100 - 2**50 
const MASK_5_2 = 2**150 - 2**100 
const MASK_5_3 = 2**200 - 2**150
const MASK_5_4 = 2**250 - 2**200 


@storage_var
func packedData() -> (num : felt):
end 

@view
func get_packedData{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (num : felt):
    let (num) = packedData.read()
    return (num)
end

@external 
func pack_2 {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num0 : felt, 
        num1 : felt 
    ):
    #Checking that the numbers are within the valid range
    assert_nn_le(num0, MAX_2)
    assert_nn_le(num1, MAX_2)

    #Shifting via multiplication
    tempvar t1 = num1*SHIFT_2_1

    packedData.write(t1 + num0)
    return ()
end

@external 
func unpack_2 {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num0 : felt,
        num1 : felt
    ):
    let (num) = packedData.read()

    #Masking out each number 
    let (num0) = bitwise_and(num, MASK_2_0)
    let (t1) = bitwise_and(num, MASK_2_1)

    #Shifting via division
    let (t1, _) = unsigned_div_rem(t1, DIV_100)
    let (num1, _) = unsigned_div_rem(t1, DIV_25)
     
    return (num0, num1)
end 


@external 
func pack_5 {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num0 : felt, 
        num1 : felt,
        num2 : felt,
        num3 : felt,
        num4 : felt 
    ):
    #Checking that the numbers are within the valid range 
    assert_nn_le(num0, MAX_5)
    assert_nn_le(num1, MAX_5)
    assert_nn_le(num2, MAX_5)
    assert_nn_le(num3, MAX_5)
    assert_nn_le(num4, MAX_5)

    #Shifting via multiplication
    tempvar t1 = num1*SHIFT_5_1
    tempvar t2 = num2*SHIFT_5_2
    tempvar t3 = num3*SHIFT_5_3
    tempvar t4 = num4*SHIFT_5_4 
    
    packedData.write(t4 + t3 + t2 + t1 + num0)
    return ()
end

@external 
func unpack_5 {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num0 : felt,
        num1 : felt,
        num2 : felt,
        num3 : felt, 
        num4 : felt 
    ):
    let (num) = packedData.read()

    #Masking out each number 
    let (num0) = bitwise_and(num, MASK_5_0)
    let (t1) = bitwise_and(num, MASK_5_1)
    let (t2) = bitwise_and(num, MASK_5_2)
    let (t3) = bitwise_and(num, MASK_5_3)
    let (t4) = bitwise_and(num, MASK_5_4)

    #Shifting via division 
    let (num1, _) = unsigned_div_rem(t1, DIV_50)
    let (num2, _) = unsigned_div_rem(t2, DIV_100)
    let (t3, _) = unsigned_div_rem(t3, DIV_100)
    let (num3, _) = unsigned_div_rem(t3, DIV_50)
    let (t4, _) = unsigned_div_rem(t4, DIV_100)
    let (num4, _) = unsigned_div_rem(t4, DIV_100)

    return (num0, num1, num2, num3, num4)
end 

#to test how divide works, there is a limit of about 2**122 for the denominator so the division by 2**125 (to perform the bitshift) must be done in 2 chunks.  
@view
func divide {range_check_ptr} (
        a : felt, 
        b : felt
    ) -> ( 
        c : felt 
    ): 
    let (c, _) = unsigned_div_rem(a,b)
    return (c)
end




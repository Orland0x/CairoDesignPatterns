%lang starknet
%builtins pedersen range_check bitwise

from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import ( unsigned_div_rem)
from starkware.cairo.common.bitwise import bitwise_and

#exploring packing felts with mutiple smaller values to minimize the number of storage slots used by a contract 

const SHIFT_UP = 2**125
const MASK_LOW = 2**125 - 1 
const MASK_HIGH = 2**250 - 2**125 
const DIV1 = 2**100
const DIV2 = 2**25

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

#takes 2 felts of max size 2^125 and packs them into a single 251 bit storage felt 
@external 
func pack_2 {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num1 : felt, 
        num2 : felt 
    ):
    tempvar s = num1*SHIFT_UP
    packedData.write(s + num2)
    return ()
end

@external 
func unpack_2 {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num1 : felt,
        num2: felt
    ):
    let (num) = packedData.read()
    let (temp) = bitwise_and(num, MASK_HIGH)
    let (temp2, _) = unsigned_div_rem(temp, DIV1)
    let (num1, _) = unsigned_div_rem(temp2, DIV2)
    let (num2) = bitwise_and(num, MASK_LOW) 
    return (num1, num2)
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




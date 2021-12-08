%lang starknet
%builtins pedersen range_check bitwise

from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin) 
from starkware.cairo.common.math import (signed_div_rem, sign, assert_nn)
from starkware.cairo.common.math_cmp import is_le
from starkware.cairo.common.alloc import alloc

from contracts.PackFelt import ( 
    pack_2,
    unpack_2, 
    pack_2_array, 
    unpack_2_array,
    pack_5,
    unpack_5, 
    pack_5_array, 
    unpack_5_array,
    pack_50,
    unpack_50,
    pack_50_array,
    unpack_50_array
)


const RANGE_CHECK_BOUND = 2 ** 64
const SCALE_FP = 100 #Scale for floating point number representation, here we use 2 decimal places hence we require a scale of 100
const THRESHOLD = 400 #Threshold value for the magnitude of the series that is a sufficient condition for divergence
const MAX_STEPS = 25 #Total numbe of iterations that will be taken per value of c, the higher it is the more accurate the fractal 


#Produces a 100x100 mandelbrot set plot and stores on chain. 


#mapping to store the packed mandelbrot set. Each key points to a column [1,50] and each corresponding key stores the pixel data for that column. 
@storage_var
func packedData(key : felt) -> (val : felt):
end 

@external 
func pack_2_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num0: felt,
        num1: felt
    ):
    let (num) = pack_2(num0, num1)
    packedData.write(0, num) 
    return ()
end 

@external
func unpack_2_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num0: felt,
        num1: felt
    ):
    let (num) = packedData.read(0)
    let (num0, num1) = unpack_2(num) 
    return (num0, num1)
end 

@external 
func pack_2_array_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num_array_len : felt, 
        num_array : felt* 
    ):
    let (num) = pack_2_array(num_array_len, num_array)
    packedData.write(0, num)
    return ()
end 

@external
func unpack_2_array_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num_array_len : felt, 
        num_array : felt* 
    ):
    let (num) = packedData.read(0) 
    let (num_array_len, num_array) = unpack_2_array(num) 
    return (num_array_len, num_array)
end 


@external 
func pack_5_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num0: felt,
        num1: felt,
        num2: felt,
        num3: felt,
        num4: felt 
    ):
    let (num) = pack_5(num0, num1, num2, num3, num4)
    packedData.write(0, num) 
    return ()
end 

@external
func unpack_5_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num0: felt,
        num1: felt,
        num2: felt,
        num3: felt,
        num4: felt 
    ):
    let (num) = packedData.read(0)
    let (num0, num1, num2, num3, num4) = unpack_5(num) 
    return (num0, num1, num2, num3, num4)
end 

@external 
func pack_5_array_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num_array_len : felt, 
        num_array : felt* 
    ):
    let (num) = pack_5_array(num_array_len, num_array)
    packedData.write(0, num)
    return ()
end 

@external
func unpack_5_array_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num_array_len : felt, 
        num_array : felt* 
    ):
    let (num) = packedData.read(0) 
    let (num_array_len, num_array) = unpack_5_array(num) 
    return (num_array_len, num_array)
end 


@external 
func pack_50_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num0 : felt, 
        num1 : felt,
        num2 : felt,
        num3 : felt,
        num4 : felt, 
        num5 : felt, 
        num6 : felt,
        num7 : felt,
        num8 : felt,
        num9 : felt,
        num10 : felt, 
        num11 : felt,
        num12 : felt,
        num13 : felt,
        num14 : felt, 
        num15 : felt, 
        num16 : felt,
        num17 : felt,
        num18 : felt,
        num19 : felt,
        num20 : felt, 
        num21 : felt,
        num22 : felt,
        num23 : felt,
        num24 : felt, 
        num25 : felt, 
        num26 : felt,
        num27 : felt,
        num28 : felt,
        num29 : felt,
        num30 : felt, 
        num31 : felt,
        num32 : felt,
        num33 : felt,
        num34 : felt, 
        num35 : felt, 
        num36 : felt,
        num37 : felt,
        num38 : felt,
        num39 : felt,
        num40 : felt, 
        num41 : felt,
        num42 : felt,
        num43 : felt,
        num44 : felt, 
        num45 : felt, 
        num46 : felt,
        num47 : felt,
        num48 : felt,
        num49 : felt,
    ):
    let (num) = pack_50(num0, num1, num2, num3, num4, num5, num6, num7, num8, num9,
            num10, num11, num12, num13, num14, num15, num16, num17, num18, num19,
            num20, num21, num22, num23, num24, num25, num26, num27, num28, num29,
            num30, num31, num32, num33, num34, num35, num36, num37, num38, num39,
            num40, num41, num42, num43, num44, num45, num46, num47, num48, num49
        )
                                    
    packedData.write(0, num) 
    return ()
end 

@external
func unpack_50_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num0 : felt, 
        num1 : felt,
        num2 : felt,
        num3 : felt,
        num4 : felt, 
        num5 : felt, 
        num6 : felt,
        num7 : felt,
        num8 : felt,
        num9 : felt,
        num10 : felt, 
        num11 : felt,
        num12 : felt,
        num13 : felt,
        num14 : felt, 
        num15 : felt, 
        num16 : felt,
        num17 : felt,
        num18 : felt,
        num19 : felt,
        num20 : felt, 
        num21 : felt,
        num22 : felt,
        num23 : felt,
        num24 : felt, 
        num25 : felt, 
        num26 : felt,
        num27 : felt,
        num28 : felt,
        num29 : felt,
        num30 : felt, 
        num31 : felt,
        num32 : felt,
        num33 : felt,
        num34 : felt, 
        num35 : felt, 
        num36 : felt,
        num37 : felt,
        num38 : felt,
        num39 : felt,
        num40 : felt, 
        num41 : felt,
        num42 : felt,
        num43 : felt,
        num44 : felt, 
        num45 : felt, 
        num46 : felt,
        num47 : felt,
        num48 : felt,
        num49 : felt,
    ):
    let (num) = packedData.read(0)
    let (num0, num1, num2, num3, num4, num5, num6, num7, num8, num9,
            num10, num11, num12, num13, num14, num15, num16, num17, num18, num19,
            num20, num21, num22, num23, num24, num25, num26, num27, num28, num29,
            num30, num31, num32, num33, num34, num35, num36, num37, num38, num39,
            num40, num41, num42, num43, num44, num45, num46, num47, num48, num49,
        ) = unpack_50(num) 

    return (num0, num1, num2, num3, num4, num5, num6, num7, num8, num9,
            num10, num11, num12, num13, num14, num15, num16, num17, num18, num19,
            num20, num21, num22, num23, num24, num25, num26, num27, num28, num29,
            num30, num31, num32, num33, num34, num35, num36, num37, num38, num39,
            num40, num41, num42, num43, num44, num45, num46, num47, num48, num49,
        )
end 

@external 
func pack_50_array_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr} (
        num_array_len : felt, 
        num_array : felt* 
    ):
    let (num) = pack_50_array(num_array_len, num_array)
    packedData.write(0, num)
    return ()
end 

@external
func unpack_50_array_test {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr} (
    ) -> (
        num_array_len : felt, 
        num_array : felt* 
    ):
    let (num) = packedData.read(0) 
    let (num_array_len, num_array) = unpack_50_array(num) 
    return (num_array_len, num_array)
end 




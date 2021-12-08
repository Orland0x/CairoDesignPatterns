import os
import pytest
from starkware.starknet.testing.starknet import Starknet
import random 

CONTRACT_FILE = os.path.join("contracts", "PackFeltTest.cairo")

@pytest.mark.asyncio
async def test_pack_2():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 2 numbers into single felt storage
    num0 = 2523434534534345
    num1 = 3234334363564634
    await contract.pack_2_test(num0,num1).invoke() 
    out = await contract.unpack_2_test().call()
    assert out.result[0] == num0
    assert out.result[1] == num1 

@pytest.mark.asyncio
async def test_pack_2_array():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 5 numbers into single felt storage
    num0 = 2523434534534345
    num1 = 3234334363564634
    await contract.pack_2_array_test([num0, num1]).invoke()
    out = await contract.unpack_2_array_test().call()
    assert out.result[0][0] == num0
    assert out.result[0][1] == num1



@pytest.mark.asyncio
async def test_pack_5():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 5 numbers into single felt storage
    num0 = 12314
    num1 = 46433
    num2 = 89665
    num3 = 34464
    num4 = 37454
    await contract.pack_5_test(num0, num1, num2, num3, num4).invoke()
    out = await contract.unpack_5_test().call()
    assert out.result[0] == num0
    assert out.result[1] == num1
    assert out.result[2] == num2
    assert out.result[3] == num3 
    assert out.result[4] == num4 

@pytest.mark.asyncio
async def test_pack_5_array():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 5 numbers into single felt storage
    num0 = 12314
    num1 = 46433
    num2 = 89665
    num3 = 34464
    num4 = 37454
    await contract.pack_5_array_test([num0, num1, num2, num3, num4]).invoke()
    out = await contract.unpack_5_array_test().call()
    assert out.result[0][0] == num0
    assert out.result[0][1] == num1
    assert out.result[0][2] == num2
    assert out.result[0][3] == num3 
    assert out.result[0][4] == num4 


@pytest.mark.asyncio
async def test_pack_50():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 50 5 bit numbers into a single felt

    #create random inputs 
    numbers = [random.randint(0,31) for i in range(50)]

    await contract.pack_50_test(*numbers).invoke() 
    out = await contract.unpack_50_test().call()

    for i in range(50):
        assert out.result[i] == numbers[i]

@pytest.mark.asyncio
async def test_pack_50_array():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 50 5 bit numbers into a single felt

    #create random inputs 
    numbers = [random.randint(0,31) for i in range(50)]

    await contract.pack_50_array_test(numbers).invoke() 
    out = await contract.unpack_50_array_test().call()

    for i in range(50):
        assert out.result[0][i] == numbers[i]

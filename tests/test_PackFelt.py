import os
import pytest
from starkware.starknet.testing.starknet import Starknet

CONTRACT_FILE = os.path.join("contracts", "PackFelt.cairo")

@pytest.mark.asyncio
async def test_increase_balance():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    #Test packing 2 numbers into single felt storage
    num0 = 2523434534534345
    num1 = 3234334363564634
    await contract.pack_2(num0,num1).invoke() 
    out = await contract.unpack_2().call()
    assert out.result[0] == num0
    assert out.result[1] == num1 

    #Test packing 5 numbers into single felt storage
    num0 = 12314
    num1 = 46433
    num2 = 89665
    num3 = 34464
    num4 = 37454
    await contract.pack_5(num0, num1, num2, num3, num4).invoke()
    out = await contract.unpack_5().call()
    assert out.result[0] == num0
    assert out.result[1] == num1
    assert out.result[2] == num2
    assert out.result[3] == num3 
    assert out.result[4] == num4   

    #division test
    # a = 2**128
    # b = 2**62 
    # out = await contract.divide(a,b).call()
    # out = await contract.divide(out.result[0],b).call()
    # print(out.result[0])


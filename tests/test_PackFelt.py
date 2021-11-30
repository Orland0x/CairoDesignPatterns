"""contract.cairo test file."""
import os
import pytest
from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
CONTRACT_FILE = os.path.join("contracts", "PackFelt.cairo")


# The testing library uses python's asyncio. So the following
# decorator and the ``async`` keyword are needed.
@pytest.mark.asyncio
async def test_increase_balance():
    """Test increase_balance method."""
    # Create a new Starknet class that simulates the StarkNet
    # system.
    starknet = await Starknet.empty()

    # Deploy the contract.
    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    num1 = 112313690470927607670360376
    num2 = 323433436356463455353355646

    #pack 2 numbers in single storage slot
    await contract.pack_2(num1,num2).invoke() 

    #view storage slot
    out = await contract.get_packedData().call()
    print(out.result[0])

    #unpack storage slot to retrieve numbers
    out = await contract.unpack_2().call()
    assert out.result[0] == num1
    assert out.result[1] == num2 


    #division test
    # a = 2**128
    # b = 2**62 
    # out = await contract.divide(a,b).call()
    # out = await contract.divide(out.result[0],b).call()
    # print(out.result[0])


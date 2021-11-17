"""contract.cairo test file."""
import os
import pytest
from starkware.starknet.testing.starknet import Starknet
import timeit
# The path to the contract source code.
CONTRACT_FILE = os.path.join("contracts", "IterateArray.cairo")


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


    start = timeit.default_timer()
    out = await contract.fill_array_wrapper([1,2,3,4,5,6]).call()
    stop = timeit.default_timer()   
    print(out.result)
    print('Time: ', stop - start)

 



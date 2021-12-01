import os
import pytest
from starkware.starknet.testing.starknet import Starknet
import timeit
CONTRACT_FILE = os.path.join("contracts", "IterateArray.cairo")

@pytest.mark.asyncio
async def test_increase_balance():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    start = timeit.default_timer()
    out = await contract.fill_array_wrapper([1,2,3,4,5,6]).call()
    stop = timeit.default_timer()   
    print(out.result)
    print('Time: ', stop - start)

 



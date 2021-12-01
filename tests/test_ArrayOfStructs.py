
import os
import pytest
from starkware.starknet.testing.starknet import Starknet
import timeit
CONTRACT_FILE = os.path.join("contracts", "ArrayOfStructs.cairo")

@pytest.mark.asyncio
async def test_increase_balance():

    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    start = timeit.default_timer()

    out = await contract.acceptArray1([4,3,5,7]).call()
    stop = timeit.default_timer()
    print(out.result[0])
    print('Time: ', stop - start)


    start = timeit.default_timer()

    out = await contract.acceptArray2([4,5],[3,7]).call()
    stop = timeit.default_timer()
    print(out.result[0])
    print('Time: ', stop - start)



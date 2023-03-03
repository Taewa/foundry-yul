object "Example" {
  code {
    // set caller address on storage slot 0
    sstore(0, caller())

    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }

  object "Runtime" {
    // Return the calldata
    code {
      switch getSelector()
      
      case 0x1036e0a8 /* onlyOwner() */ {
        if iszero(calledByOwner()) {
          revert(0, 0)
        }

        mstore(0, owner())
        return(0, 0x20)
      }

      // owner storage position
      function ownerPos() -> p { p := 0 }

      // to get owner address
      function owner() -> o {
        o := sload(ownerPos())
      }

      // whether a caller is the owner or not
      function calledByOwner() -> cbo {
        cbo := eq(owner(), caller())
      }

      // Picks up external function's name (hex)
      function getSelector() -> selector {
        // cut out everything but the first 4 bytes via integer division
        selector := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
      }
    }
  }
}
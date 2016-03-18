contract Helpers {
    
    //By: D-Nice
    //Sending function that is compatible with contracts as well. Using built-in send will normally cause inter-contract transactions to fail
    function safeSend(address _receiver, uint _amtToSend) private {
        if (_amtToSend > 0) {
            bool success = _receiver.send(_amtToSend);
            if (!success)
    	        _receiver.call.value(_amtToSend); //May add .gas limit to set a max in case of parasitic contracts, see commented out method below 
                //_receiver.call.value(_amtToSend).gas(maxGashere);
	   }
	}

    //By: D-Nice
    //Checks if two strings are equal by comparing their hashes. Most efficient compare function, when amount of characters isn't large
    //Have yet to test when you get diminishing returns on gas cost, but as character amount rises, other string compare functions become more efficient
    function stringsEqual(string _a, string _b) returns (bool) {
	    return sha3(_a) == sha3(_b) ? true : false;
	}
}

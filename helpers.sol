//By: D-Nice
//Make a new contract if you commit any new helpers, using your name pre helpers.
contract DNiceHelpers {

    //Sending function that is compatible with contracts as well. Using built-in send will normally cause inter-contract transactions to fail
    function safeSend(address _receiver, uint _amtToSend) private {
        if (_amtToSend > 0) {
            bool success = _receiver.send(_amtToSend);
            if (!success)
    	        _receiver.call.value(_amtToSend); //May add .gas limit to set a max in case of parasitic contracts, see commented out method below 
                //_receiver.call.value(_amtToSend).gas(maxGashere);
        }
    }

    //Checks if two strings are equal by comparing their hashes. Most efficient compare function, when amount of characters isn't large
    //Have yet to test when you get diminishing returns on gas cost, but as character amount rises, other string compare functions become more efficient
    function stringsEqual(string _a, string _b) returns (bool) {
    	return sha3(_a) == sha3(_b) ? true : false;
    }

	//The following is a combination of functions to recursively floor round an integer:
	
	//This constant function will convert a _number to be floored to the first _roundTo digits designated
	//e.g. numberToRound(123456, 2) = 120000
	function numberToRound(uint _number, uint _roundTo) constant returns (uint) {
        return recursiveFloor(_number, _roundTo, findFigures(_number));
    }
    
    function recursiveFloor(uint _number, uint _roundTo, uint _unit) private constant returns (uint) {
        uint _rounded = _number / ((10**_unit) / 10);
        if (_rounded >= 1 * ((10**_roundTo) / 10))
            return _rounded * ((10**_unit) / 10);
        else
            return recursiveFloor(_number, _roundTo, _unit - 1);
    }
    
    function findFigures(uint _number, uint _unit) private constant returns (uint) {
        if (_number / (10**_unit / 10) < 10)
            return _unit;
        else
            return findFigures(_number, _unit + 1);
    }
    
    function findFigures(uint _number) private constant returns (uint) {
        return findFigures(_number, 1);
    }
    //Rounding function combo ends here

}

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

	//The following is a combination of functions to recursively round an unsigned integer:
	
    function uintCeil(uint _number, uint _roundTo) private constant returns (uint) {
        uint _unit = findFigures(_number);
        if (_number == 0 || _unit <= _roundTo)
            return _number;
        return recursiveCeil(_number, _roundTo, _unit);
    }
    
    function uintRound(uint _number, uint _roundTo) private constant returns (uint) {
        uint _unit = findFigures(_number);
        if (_number == 0 || _unit <= _roundTo)
            return _number;
        return recursiveRound(_number, _roundTo, _unit);
    }
    
    function uintFloor(uint _number, uint _roundTo) private constant returns (uint) {
        uint _unit = findFigures(_number);
        if (_number == 0 || _unit <= _roundTo)
            return _number;
        return recursiveFloor(_number, _roundTo, _unit);
    }
    
    function recursiveFloor(uint _number, uint _roundTo, uint _unit) private constant returns (uint) {
        uint expUnit = power10(_unit);
        uint rounded = _number / expUnit;
        if (rounded >= 1 * power10(_roundTo))
            return rounded * expUnit;
        else
            return recursiveFloor(_number, _roundTo, _unit - 1);
    }
    
    function recursiveCeil(uint _number, uint _roundTo, uint _unit) private constant returns (uint) {
        uint expUnit = power10(_unit);
        uint rounded = _number / expUnit;
        if (rounded >= 1 * power10(_roundTo))
            return rounded * expUnit + (1 * expUnit);
        else
            return recursiveCeil(_number, _roundTo, _unit - 1);
    }
    
    function recursiveRound(uint _number, uint _roundTo, uint _unit) private constant returns (uint) {
        uint expUnit = power10(_unit);
        uint rounded = _number / expUnit;
        if (rounded >= 1 * power10(_roundTo)) {
            uint preRounded = _number / power10(_unit - 1);
            if (preRounded % 10 >= 5)
                return rounded * expUnit + (1 * expUnit);
            else
                return rounded * expUnit;
        }
        else
            return recursiveRound(_number, _roundTo, _unit - 1);
    }
    
    function findFigures(uint _number, uint _unit) private constant returns (uint) {
        if (_number / power10(_unit) < 10)
            return _unit;
        else
            return findFigures(_number, _unit + 1);
    }
    
    function findFigures(uint _number) private constant returns (uint) {
        return findFigures(_number, 1);
    }
    
    function power10(uint _number) private constant returns (uint) {
        return (10**_number) / 10;
    }
    //Rounding function combo ends here

}

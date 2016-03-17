# solidity-helper-functions
A collection of solidity helper functions meant to make DApp development for Ethereum even more streamlined and easier. 

I will initially be adding some of my own, with descriptions of what they are intended for. If you would like to add your own, please fork the repo and make a pull request. Please properly comment your code.

The most integral helper function currently within this collection, is the safeSend function, which is intended to ensure that your DApp can interact with wallet contracts and other contracts. Currently, using the send method, will result in failure to send to other contracts.

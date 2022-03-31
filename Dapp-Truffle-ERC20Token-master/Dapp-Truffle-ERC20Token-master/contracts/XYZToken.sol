pragma solidity ^0.4.2;

contract XYZToken {
	string public name = "XYZ Token";
	string public symbol = "XYZ";
	string public standard = "XYZ Token v1.0";
	uint256 public totalSupply;

	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;

	event Transfer(
		address indexed _from, 
		address indexed _to, 
		uint256 _value
	);

	event Approval(
		address indexed _owner, 
		address indexed _spender, 
		uint256 _value
	);

	// ********* CONSTRUCTOR ********* //
	function XYZToken(uint256 _initialSupply) public {
		// allocate the initial supply to admin
		balanceOf[msg.sender] = _initialSupply;
 		totalSupply = _initialSupply;
	}

	// ********* TRANSFER ********* //
	function transfer(address _to, uint256 _value) public returns (bool success) {
		// Throws an exception if sender's account doesn't have enough
		require(balanceOf[msg.sender] >= _value);

		// Transfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		// Trigger Transfer event
		Transfer(msg.sender, _to, _value);

		// Returns a boolean
		return true;
	}

	// ********* DELEGATED TRANSFER ********* //
	// approve (_spender: account that approves on our behalf)
	function approve(address _spender, uint256 _value) returns (bool success) {
		// allowance
		allowance[msg.sender][_spender] = _value;

		// Approve event 
		Approval(msg.sender, _spender, _value);

		// Returns a boolean
		return true;
	}

	// transferFrom
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		// Require _from has enough tokens
		require(_value <= balanceOf[_from]);
		// Require allowance is big enough 
		require(_value <= allowance[_from][msg.sender]);

		// Change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;

		// Update the allowance
		allowance[_from][msg.sender] -= _value;

		// Trigger Transfer event
		Transfer(_from, _to, _value);

		// Returns a boolean
		return true;
	}

}



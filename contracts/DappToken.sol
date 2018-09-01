//version solidity
pragma solidity 0.4.24;

//contrato (nombre)
contract DappToken{

	//variables o constantes
	string public constant name = "Consensys Token";
	string public constant symbol = "CSYS";

	uint256 public totalSupply;

	//eventos
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);
	//mappings
	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;


	//constructor
	constructor(uint256 _initialSupply) public{
		totalSupply = _initialSupply;
		balanceOf[msg.sender] = _initialSupply;
	}


	//metodos
	function transfer(address _to, uint256 _value) public returns(bool success){
		//validacion
		require(balanceOf[msg.sender] >= _value);

		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		emit Transfer(msg.sender, _to, _value);

		return true;
	}

	function approve(address _spender, uint256 _value) public returns (bool success){

		allowance[msg.sender][_spender] = _value;

		emit Approval(msg.sender, _spender, _value);

		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
		//validar tokens suficientes
		require(_value <= balanceOf[_from]);

		//allowance es suficientemente grande
		require(_value <= allowance[_from][msg.sender]);

		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;

		//actualizamos allowance
		allowance[_from][msg.sender] += _value;

		//ejecutamos evento Transfer
		emit Transfer(_from, _to, _value);

		return true;

	}
	
}



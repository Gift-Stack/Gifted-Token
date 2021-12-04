// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import './TokenInterface.sol';

contract Token is TokenInterface {
  address public owner;
  uint256 public _totalSupply;
  mapping(address => uint256) public approved;
  mapping(address => uint256) public _balanceOf;

  string public name = 'Gifted Token';
  uint8 public decimal = 18;
  string public symbol = 'GFT';

  constructor() {
    owner = msg.sender;
    _totalSupply = 100;
    _balanceOf[msg.sender] = 100;
  }

  function totalSupply() public view virtual override returns (uint256) {
    return _totalSupply;
  }

  function transfer(address _to, uint256 _value)
    public
    virtual
    override
    returns (bool)
  {
    require(_value <= _balanceOf[msg.sender]);
    _balanceOf[msg.sender] -= _value;
    _balanceOf[_to] += _value;
    emit Transfer(msg.sender, _to, _value);

    return true;
  }

  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  ) external override returns (bool) {
    require(_value <= _balanceOf[_from]);
    _balanceOf[_from] -= _value;
    _balanceOf[_to] += _value;
    emit Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value)
    external
    override
    returns (bool)
  {
    require(_value <= _balanceOf[msg.sender]);
    require(approved[_spender] == 0);
    approved[_spender] = _value;

    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender)
    external
    view
    override
    returns (uint256)
  {
    return approved[_spender];
  }

  function balanceOf(address _owner)
    public
    view
    virtual
    override
    returns (uint256)
  {
    return _balanceOf[_owner];
  }

  function mint(address _to, uint256 _value)
    public
    virtual
    override
    returns (bool)
  {
    require(_value <= _totalSupply);
    _balanceOf[_to] += _value;
    _totalSupply += _value;
    emit Transfer(address(0), _to, _value);
    return true;
  }

  function burn(uint256 _value) public virtual override returns (bool) {
    require(_value <= _balanceOf[msg.sender]);
    _balanceOf[msg.sender] -= _value;
    _totalSupply -= _value;
    emit Transfer(msg.sender, address(0), _value);
    return true;
  }
}

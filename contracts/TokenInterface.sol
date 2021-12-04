// SPDX-License-Identifier: MIT

pragma solidity >0.4.0;

interface TokenInterface {
  function totalSupply() external view returns (uint256);

  function transfer(address _to, uint256 _value)
    external
    returns (bool success);

  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  ) external returns (bool success);

  function approve(address _spender, uint256 _value)
    external
    returns (bool success);

  function allowance(address _owner, address _spender)
    external
    view
    returns (uint256 remaining);

  function balanceOf(address _owner) external view returns (uint256);

  function mint(address _to, uint256 _value) external returns (bool success);

  function burn(uint256 _value) external returns (bool success);

  // Events
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(
    address indexed _owner,
    address indexed _spender,
    uint256 _value
  );
}

pragma solidity ^0.5.8;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'TransportationRole' to manage this role - add, remove, check
contract TransportationRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event TransportationAdded(address indexed account);
  event TransportationRemoved(address indexed account);

  // Define a struct 'Transportations' by inheriting from 'Roles' library, struct Role
  Roles.Role private Transportations;

  // In the constructor make the address that deploys this contract the 1st Transportation
  constructor() public {
    _addTransportation(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyTransportation() {
    require(isTransportation(msg.sender),"Only Transportations allowed.");
    _;
  }

  // Define a function 'isTransportation' to check this role
  function isTransportation(address account) public view returns (bool) {
    return Transportations.has(account);
  }

  // Define a function 'addTransportation' that adds this role
  function addTransportation(address account) public onlyTransportation {
    _addTransportation(account);
  }

  // Define a function 'renounceTransportation' to renounce this role
  function renounceTransportation() public {
    _removeTransportation(msg.sender);
  }

  // Define an internal function '_addTransportation' to add this role, called by 'addTransportation'
  function _addTransportation(address account) internal {
    Transportations.add(account);
    emit TransportationAdded(account);

  }

  // Define an internal function '_removeTransportation' to remove this role, called by 'removeTransportation'
  function _removeTransportation(address account) internal {
    Transportations.remove(account);
    emit TransportationRemoved(account);

  }
}
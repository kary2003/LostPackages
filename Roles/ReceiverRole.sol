pragma solidity ^0.5.8;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'ReceiverRole' to manage this role - add, remove, check
contract ReceiverRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event ReceiverAdded(address indexed account);
  event ReceiverRemoved(address indexed account);

  // Define a struct 'Receivers' by inheriting from 'Roles' library, struct Role
  Roles.Role private Receivers;

  // In the constructor make the address that deploys this contract the 1st Receiver
  constructor() public {
    _addReceiver(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyReceiver() {
    require(isReceiver(msg.sender),"Only Receivers allowed.");
    _;
  }

  // Define a function 'isReceiver' to check this role
  function isReceiver(address account) public view returns (bool) {
    return Receivers.has(account);
  }

  // Define a function 'addReceiver' that adds this role
  function addReceiver(address account) public onlyReceiver {
    _addReceiver(account);
  }

  // Define a function 'renounceReceiver' to renounce this role
  function renounceReceiver() public {
    _removeReceiver(msg.sender);
  }

  // Define an internal function '_addReceiver' to add this role, called by 'addReceiver'
  function _addReceiver(address account) internal {
    Receivers.add(account);
    emit ReceiverAdded(account);

  }

  // Define an internal function '_removeReceiver' to remove this role, called by 'removeReceiver'
  function _removeReceiver(address account) internal {
    Receivers.remove(account);
    emit ReceiverRemoved(account);

  }
}
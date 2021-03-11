pragma solidity ^0.5.8;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'SenderRole' to manage this role - add, remove, check

contract SenderRole {
  using Roles for Roles.Role;
  
  // Define 2 events, one for Adding, and other for Removing
  event SenderAdded(address indexed account);
  event SenderRemoved(address indexed account);
  // Define a struct 'Senders' by inheriting from 'Roles' library, struct Role
  Roles.Role private Senders;
  constructor() public {
    _addSender(msg.sender);
  }
  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlySender() {
    require(isSender(msg.sender),"Only Senders allowed.");
    _;
  }
  // Define a function 'isSender' to check this role
  function isSender(address account) public view returns (bool) {
    return Senders.has(account);
  }
  // Define a function 'addSender' that adds this role
  function addSender(address account) public onlySender {
    _addSender(account);
  }
  // Define a function 'renounceSender' to renounce this role
  function renounceSender() public {
    _removeSender(msg.sender);
  }
  // Define an internal function '_addSender' to add this role, called by 'addSender'
  function _addSender(address account) internal {
    Senders.add(account);
    emit SenderAdded(account);
  }
  // Define an internal function '_removeSender' to remove this role, called by 'removeSender'
  function _removeSender(address account) internal {
    Senders.remove(account);
    emit SenderRemoved(account);
  }
}
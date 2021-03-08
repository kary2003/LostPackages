pragma solidity ^0.5.8;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'ReceiverRole' to manage this role - add, remove, check
contract'ReceiverRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event'ReceiverAdded(address indexed account);
  event'ReceiverRemoved(address indexed account);

  // Define a struct 'Receivers' by inheriting from 'Roles' library, struct Role
  Roles.Role private'Receivers;

  // In the constructor make the address that deploys this contract the 1st'Receiver
  constructor() public {
    _ad'Receiver(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onl'Receiver() {
    require(i'Receiver(msg.sender),"Only'Receivers allowed.");
    _;
  }

  // Define a function 'i'Receiver to check this role
  function i'Receiver(address account) public view returns (bool) {
    return'Receivers.has(account);
  }

  // Define a function 'ad'Receiver that adds this role
  function ad'Receiver(address account) public onl'Receiver {
    _ad'Receiver(account);
  }

  // Define a function 'renounc'Receiver to renounce this role
  function renounc'Receiver() public {
    _remov'Receiver(msg.sender);
  }

  // Define an internal function '_ad'Receiver to add this role, called by 'ad'Receiver
  function _ad'Receiver(address account) internal {
'Receivers.add(account);
    emit'ReceiverAdded(account);

  }

  // Define an internal function '_remov'Receiver to remove this role, called by 'remov'Receiver
  function _remov'Receiver(address account) internal {
'Receivers.remove(account);
    emit'ReceiverRemoved(account);

  }
}
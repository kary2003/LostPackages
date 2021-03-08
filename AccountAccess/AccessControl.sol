pragma solidity ^0.5.8;

import "./SenderRole.sol";
import './DistributorRole.sol';
import './TransportationRole.sol';
import './ReceiverRole.sol';


contract AccessControl is SenderRole, DistributorRole, TransportationRole, ReceiverRole {
  constructor() public {}
}

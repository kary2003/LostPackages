pragma solidity ^0.5.8;

import './AccessControl.sol';
import './Ownable.sol';
import "./Roles.sol";
import './SenderRole.sol';
// import './DistributorRole.sol';
//import './TransportationRole.sol';
//import './ReceiverRole.sol';


// Define a contract 'Supplychain'
contract SupplyChain is Ownable, AccessControl  {

  // Define 'owner'
  // address owner;

  // Define a variable called 'QR' for Universal Product Code (QR)
  uint  QR;

  // Define a variable called 'sku' for Stock Keeping Unit (SKU)
  uint  sku;

  // Define a public mapping 'items' that maps the QR to an Item.
  mapping (uint => Item) items;

  // Define a public mapping 'itemsHistory' that maps the QR to an array of TxHash,
  // that track its journey through the supply chain -- to be sent from DApp.
  mapping (uint => string[]) itemsHistory;
  
  // Define enum 'State' with the following values:
  enum State
  {
    Purchased,  // 0  
    Processed,  // 1  
    Packed,     // 2
    Shipped,    // 3
    Received    // 4
    }

  State constant defaultState = State.Purchased;

  // Define a struct 'Item' with the following fields:
  struct Item {
    uint    QR; // Universal Product Code (QR), generated by the Sender, goes on the package, can be verified by the Consumer
    address ownerID;  // Metamask-Ethereum address of the current owner as the product moves through 8 stages
    address originSenderID; // Metamask-Ethereum address of the Sender
    string  originSenderName; //  Name
    string  originSenderInformation;  //  Information
    string  originSenderLatitude; //  Latitude
    string  originSenderngitude;  // Senderongitude
    uint    productID;  // Product ID potentially a combination of QR + sku
    string  productNotes; // Product Notes
    uint    productPrice; // Product Price
    State   itemState;  // Product State as represented in the enum above
    address distributorID;  // Metamask-Ethereum address of the Distributor
    address transportationID; // Metamask-Ethereum address of the Transportation
    address reciverID; // Metamask-Ethereum address of the Reciever
  }
  
    // Define 8 events with the same 8 state values and accept 'QR' as input argument
  event Purchased(uint indexed QR);
  event Processed(uint indexed QR);
  event Packed(uint indexed QR);
  event Shipped(uint indexed QR);
  event Received(uint indexed QR,address retailerID);
  
    // Define a modifer that checks to see if msg.sender == owner of the contract
  // modifier onlyOwner() {
  //   require(msg.sender == owner);
  //   _;
  // }

  // Define a modifer that verifies the Caller
  modifier verifyCaller (address _address) {
    require(msg.sender == _address); 
    _;
  }
  
   // Define a modifier that checks if the paid amount is sufficient to cover the price
  modifier paidEnough(uint _price) { 
    require(msg.value >= _price); 
    _;
  }
  
  // Define a modifier that checks the price and refunds the remaining balance
  modifier checkValue(uint _QR) {
    _;
    uint _price = items[_QR].productPrice;
    uint amountToReturn = msg.value - _price;
    msg.sender.transfer(amountToReturn);
  }

  modifier onlyItemOwnerOrOwner(uint _QR) {
    require(items[_QR].ownerID == msg.sender || isOwner(),"caller is not the owner of the item");
    _;
  }

 // Define a modifier that checks if an item.state of a QR is Processed
  modifier processed(uint _QR) {
    require(items[_QR].itemState == State.Processed,"invalid state, expected Processed");
    _;
  }
  
  // Define a modifier that checks if an item.state of a QR is Packed
  modifier packed(uint _QR) {
    require(items[_QR].itemState == State.Packed,"invalid state, expected Packed");

    _;
  }


 // Define a modifier that checks if an item.state of a QR is Shipped
  modifier shipped(uint _QR) {
    require(items[_QR].itemState == State.Shipped,"invalid state, expected Shipped");
    _;
  }

  // Define a modifier that checks if an item.state of a QR is Received
  modifier received(uint _QR) {
    require(items[_QR].itemState == State.Received,"invalid state, expected Received");
    _;
  }
  
    // In the constructor set 'owner' to the address that instantiated the contract
  // and set 'sku' to 1
  // and set 'upc' to 1
  constructor() public payable {
    // owner = msg.sender;
    //sku = 1;
    QR = 1;
  }
}
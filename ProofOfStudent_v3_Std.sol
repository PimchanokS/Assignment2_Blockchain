// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
pragma experimental ABIEncoderV2;
contract ProofOfStudent {  

  mapping (bytes32 => bool) private listStudent;
      
      struct Reserved{
        string times;
        string rooms;
        string owner;
    }
    Reserved[] reserved;
  

  //---events---
  event NameAdded(
    address from,   
    string text,
    bytes32 hash
  );
  
  event RegistrationError(
    address from,
    string text,
    string reason
  );


  // store the proof for a student in the contract state
  function recordProof(bytes32 proof) private {
    listStudent[proof] = true;
  }
  
  // record a student name
  function registration(string memory name,  string memory owner, string memory time ) public payable {
    
    //---check if string was previously stored---
    // if (listStudent[hashing(name)]) {
    //   emit RegistrationError(msg.sender, name, "This tring was previously stored");
    //   payable(msg.sender).transfer(msg.value);
    //     return;
    // }
    if (listStudent[hashing(name)]) {
        
        emit RegistrationError(msg.sender, name, "Sorry, the room has been reserved.");
        payable(msg.sender).transfer(msg.value);
        return;
    }

    if((hashing(name)) == (hashing("Single"))){
      if (msg.value != 0.001 ether) {
        emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.001 ether");
        payable(msg.sender).transfer(msg.value);
        return;
      }
    }else if((hashing(name)) == (hashing("Double"))){
      if (msg.value != 0.002 ether) {
        emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.002 ether");
        payable(msg.sender).transfer(msg.value);
        return;
      }
    }else if((hashing(name)) == (hashing("Triple"))){
      if (msg.value != 0.003 ether) {
        emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.003 ether");
        payable(msg.sender).transfer(msg.value);
        return;
      }
    }else if((hashing(name)) == (hashing("Quad"))){
      if (msg.value != 0.004 ether) {
        emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.004 ether");
        payable(msg.sender).transfer(msg.value);
        return;
      }
    }else if((hashing(name)) == (hashing("Queen"))){
      if (msg.value != 0.005 ether) {
        emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.005 ether");
        payable(msg.sender).transfer(msg.value);
        return;
      }
    }else if((hashing(name)) == (hashing("King"))){
      if (msg.value != 0.006 ether) {
        emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.006 ether");
        payable(msg.sender).transfer(msg.value);
        return;
      }
    }else{
      emit RegistrationError(msg.sender, name, "Room not found, please contact staff");
      payable(msg.sender).transfer(msg.value);
      return;
    }
    
 
    recordProof(hashing(name));

    reserved.push(Reserved(time,name,owner));
    
    //---fire the event---
    emit NameAdded(msg.sender, name, hashing(name));
    
  }
  
  // SHA256 for Integrity
  function hashing(string memory name) private 
  pure returns (bytes32) {
    return sha256(bytes(name));
  }
  
  // check name of student in this class
  function checkName(string memory name) public 
  view returns (bool) {
    return listStudent[hashing(name)];
  }
  function getReserved() public view returns(Reserved[] memory){
    return reserved;
  }
  // function checkTime(string memory time) public 
  // pure returns (string memory) {
  //   return time;
  // }
}
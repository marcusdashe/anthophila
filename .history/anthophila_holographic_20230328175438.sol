pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract HolographicWill {

    address private owner;
	enum NonTestatorType { Beneficiary, Doctor}

 // Testator Details Struct
   struct Testator {
        address addr;
        string name;
        string password;
        bool isLogin;
        bool isDead; // boolean to indicate whether the testator is dead or not
        bool allNonTestatorsSigned; // boolean to indicate whether all non-testators have signed the holographic will
        string willIPFSCID; // IPFS hash of the holographic will file 
        uint id;
        uint[] nonTestatorsIds;
    }

// Beneficiary and Doctor Deatails Struct
	struct NonTestator {
        address addr;
        string name;
        string password;
        bool isLogin;
        bool hasSign;
        uint id;
		address testatorAddr; 
        NonTestatorType userType; // enum that holds either beneficiary or Crooner or doctor details
    }

    Testator[] testators;
    NonTestator[] nonTestators;

    // mapping of testator address to an array of beneficiary addresses
    mapping(address => address[]) beneficiaries;
    // mapping of beneficiary addresses to a boolean indicating whether they have signed the will or not
    mapping(address => bool) beneficiarySignatures;
    mapping(address => uint[]) nonTestatorsMap;
    mapping(address => bool) isTestator;
    mapping(address => bool) isBeneficiary;
    mapping(address => bool) isBeneficiaryLoggedIn;


   function addTestator(address _addr) internal {
    isTestator[_addr] = true;
   }

   function addBeneficiary(address beneficiary) public onlyTestator {
    beneficiaries[msg.sender].push(beneficiary);
}

   function getTestatorIndex(address testatorAddress) internal view returns (uint) {
    for (uint i = 0; i < testators.length; i++) {
        if (testators[i].addr == testatorAddress) {
            return i;
        }
    }
    revert("Testator not found");
}


    modifier onlyTestator() {
        require(isTestator[msg.sender], "Only testators can call this function");
        _;
    }

    modifier onlyLoggedInTestator() {
        require(isTestator[msg.sender], "Only testators can call this function");
        require(testators[getTestatorIndex(msg.sender)].isLogin, "Testator must be logged in to call this function");
        _;
    }

    modifier onlyNewTestator() {
        require(!isTestator[msg.sender], "Address already registered as Testator");
        _;
    }


modifier onlyBeneficiary() {
    require(isBeneficiary[msg.sender], "Only beneficiaries can call this function");
    _;
}

modifier onlyLoggedInBeneficiary() {
    require(isBeneficiary[msg.sender], "Only beneficiaries can call this function");
    // require(nonTestators[nonTestatorsMap[msg.sender][0]].isLogin, "Beneficiary must be logged in to call this function");
    _;
}


modifier onlyDoctor() {
    bool found = false;
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].userType == NonTestatorType.Doctor && nonTestators[i].isLogin) {
            found = true;
            break;
        }
    }
    require(found, "Only logged-in doctors can call this function");
    _;
}

	
modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the smart contract can call this function.");
        _; // Continue executing the function if the modifier passes
    }

constructor() {
        owner = msg.sender; // Set the creator of the contract to be the owner       
    }

function uploadWillIPFSCID(string memory ipfsCID) public onlyLoggedInTestator {
    uint testatorIndex = getTestatorIndex(msg.sender);
    require(!testators[testatorIndex].isDead, "Cannot upload will for a deceased testator");
    testators[testatorIndex].willIPFSCID = ipfsCID;
}

/* 
	This function takes in the following parameters:

	_addr: The address of the non-Testator to be added.
	_name: The name of the non-Testator to be added.
	_password: The password of the non-Testator to be added.
	_userType: An integer representing the type of non-Testator to be added, where 0 = Beneficiary, 1 = Doctor
	The function then converts the _userType integer to the corresponding NonTestatorType enum value. It creates a new NonTestator struct with the given parameters and sets the isLogin and hasSign properties to false.
*/

function addNonTestator(address _addr, string memory _name, uint _userType) public onlyTestator {
    NonTestatorType userType = NonTestatorType(_userType);
    NonTestator memory newNonTestator = NonTestator(_addr, _name, "", false, false, nonTestators.length, msg.sender, userType);
    nonTestators.push(newNonTestator);
    testators[getTestatorIndex(msg.sender)].nonTestatorsIds.push(nonTestators.length);
}

function getTestatorBeneficiaries() public view onlyLoggedInTestator returns (NonTestator[] memory) {
    Testator storage testator = testators[getTestatorIndex(msg.sender)];
    uint[] memory beneficiaryIds = testator.nonTestatorsIds;
    uint beneficiaryCount = 0;

    // Count the number of beneficiaries
    for (uint i = 0; i < beneficiaryIds.length; i++) {
        if (nonTestators[beneficiaryIds[i]].userType == NonTestatorType.Beneficiary) {
            beneficiaryCount++;
        }
    }

    // Create an array to hold the beneficiaries
    NonTestator[] memory beneficiaries = new NonTestator[](beneficiaryCount);

    // Add the beneficiaries to the array
    uint beneficiaryIndex = 0;
    for (uint i = 0; i < beneficiaryIds.length; i++) {
        if (nonTestators[beneficiaryIds[i]].userType == NonTestatorType.Beneficiary) {
            beneficiaries[beneficiaryIndex] = nonTestators[beneficiaryIds[i]];
            beneficiaryIndex++;
        }
    }

    return beneficiaries;
}


function getAssociatedDoctors() public view onlyLoggedInTestator returns (NonTestator[] memory) {
    Testator storage currentTestator = testators[getTestatorIndex(msg.sender)];
    uint[] memory nonTestatorIds = currentTestator.nonTestatorsIds;
    NonTestator[] memory doctors = new NonTestator[](nonTestatorIds.length);

    uint doctorsCount = 0;
    for (uint i = 0; i < nonTestatorIds.length; i++) {
        NonTestator memory currentNonTestator = nonTestators[nonTestatorIds[i]];
        if (currentNonTestator.userType == NonTestatorType.Doctor) {
            doctors[doctorsCount] = currentNonTestator;
            doctorsCount++;
        }
    }

    NonTestator[] memory result = new NonTestator[](doctorsCount);
    for (uint i = 0; i < doctorsCount; i++) {
        result[i] = doctors[i];
    }

    return result;
}


function deleteNonTestator(uint nonTestatorId) public onlyLoggedInTestator {
    Testator storage testator = testators[getTestatorIndex(msg.sender)];
    require(nonTestatorId < testator.nonTestatorsIds.length, "Invalid non-testator ID");

    NonTestator storage nonTestator = nonTestators[testator.nonTestatorsIds[nonTestatorId]];
    require(nonTestator.testatorAddr == msg.sender, "Non-testator not associated with testator");

    // Remove the non-testator from the testator's list of associated non-testators
    testator.nonTestatorsIds[nonTestatorId] = testator.nonTestatorsIds[testator.nonTestatorsIds.length - 1];
    testator.nonTestatorsIds.pop();

    // Remove the non-testator from the nonTestators array
    nonTestators[nonTestator.id] = nonTestators[nonTestators.length - 1];
    nonTestators.pop();
}


function registerTestator(string memory _name, string memory _password) public onlyNewTestator returns (bool) {
    Testator memory newTestator = Testator(msg.sender, _name, _password, false, true, false, "", testators.length, new uint[](0));
    testators.push(newTestator);
    addTestator(msg.sender);
    return true;
}

function loginTestator(string memory password) public returns (bool) {
    uint testatorIndex = getTestatorIndex(msg.sender);
    require(keccak256(bytes(testators[testatorIndex].password)) == keccak256(bytes(password)), "Incorrect password");
    testators[testatorIndex].isLogin = true;
    return true;
}

function signupBeneficiary(string memory _name, string memory _password) public {
    require(!isTestator[msg.sender], "Address already registered as Testator");
    NonTestator memory newBeneficiary = NonTestator(msg.sender, _name, _password, false, false, nonTestators.length, address(0), NonTestatorType.Beneficiary);
    nonTestators.push(newBeneficiary);
    isBeneficiary[msg.sender] = true;
}

function loginBeneficiary(string memory _password) public {
    require(isBeneficiary[msg.sender], "Address not registered as Beneficiary");
    uint[] memory beneficiaryIds = nonTestatorsMap[msg.sender];
    bool found = false;
    for (uint i = 0; i < beneficiaryIds.length; i++) {
        uint beneficiaryIndex = beneficiaryIds[i];
        string storage beneficiaryPassword = nonTestators[beneficiaryIndex].password;
        if (keccak256(bytes(beneficiaryPassword)) == keccak256(bytes(_password)) && nonTestators[beneficiaryIndex].userType == NonTestatorType.Beneficiary) {
            nonTestators[beneficiaryIndex].isLogin = true;
            isBeneficiaryLoggedIn[msg.sender] = true;
            found = true;
            break;
        }
    }
    require(found, "Incorrect password or user type");
}

// function beneficiaryLogout() public onlyLoggedInBeneficiary {
//     nonTestators[nonTestatorsMap[msg.sender][0]].isLogin = false;
//     isBeneficiaryLoggedIn[msg.sender] = false;
// }

// function logoutBeneficiary() public onlyLoggedInBeneficiary {
//     uint beneficiaryIndex = nonTestatorsMap[msg.sender][0];
//     nonTestators[beneficiaryIndex].isLogin = false;
//     isBeneficiaryLoggedIn[msg.sender] = false;
// }


function signinDoctor(string memory _password) public {
    bool found = false;
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].userType == NonTestatorType.Doctor) {
            require(keccak256(abi.encodePacked(_password)) == keccak256(abi.encodePacked(nonTestators[i].password)), "Invalid password");
            nonTestators[i].isLogin = true;
            found = true;
            break;
        }
    }
    require(found, "Doctor not found");
}


// Function to declare a testator dead
function declareTestatorDead(address testatorAddress) public onlyDoctor {
    uint testatorIndex = getTestatorIndex(testatorAddress);
    testators[testatorIndex].isDead = true;
}

// function for a beneficiary to sign the will
function signWill() public onlyLoggedInBeneficiary {
    beneficiarySignatures[msg.sender] = true;
    uint beneficiaryCount = beneficiaries[testators[getTestatorIndex(msg.sender)].addr].length;

    // check if all beneficiaries have signed
    for (uint i = 0; i < beneficiaryCount; i++) {
        if (!beneficiarySignatures[beneficiaries[testators[getTestatorIndex(msg.sender)].addr][i]]) {
            return; // exit the function if not all beneficiaries have signed
        }
    }

    // all beneficiaries have signed, reveal the willIPFSCID
    testators[getTestatorIndex(msg.sender)].allNonTestatorsSigned = true;
}


function allBeneficiariesSigned() public view returns (bool) {
    Testator storage testator = testators[getTestatorIndex(msg.sender)];
    address[] storage testatorBeneficiaries = beneficiaries[msg.sender];

    for (uint i = 0; i < testatorBeneficiaries.length; i++) {
        if (!beneficiarySignatures[testatorBeneficiaries[i]]) {
            return false;
        }
    }

    return testator.allNonTestatorsSigned;
}

event WillIPFSCID(string ipfsCID);

function revealWillIPFSCID() public onlyLoggedInBeneficiary {
    address testatorAddress = nonTestators[nonTestatorsMap[msg.sender][0]].testatorAddr;
    Testator storage testator = testators[getTestatorIndex(testatorAddress)];
    require(testator.allNonTestatorsSigned, "Cannot reveal will IPFS CID until all non-testators have signed");
    require(beneficiaries[testatorAddress].length > 0, "No beneficiaries associated with this Testator");
    for (uint i = 0; i < beneficiaries[testatorAddress].length; i++) {
        require(beneficiarySignatures[beneficiaries[testatorAddress][i]], "Beneficiary has not signed yet");
    }
    require(bytes(testator.willIPFSCID).length > 0, "Will IPFS CID not set yet");
    emit WillIPFSCID(testator.willIPFSCID);
}
	
// Returns the details of a Beneficiary for a given testator
// function getBeneficiaryDetails(uint testatorIndex, uint beneficiaryIndex) public view onlyTestator returns (address, string memory, bool, bool, uint) {
//     NonTestator memory beneficiary = testators[testatorIndex].nonTestators[beneficiaryIndex];
//     require(beneficiary.userType == NonTestatorType.Beneficiary, "The provided index does not correspond to a Beneficiary");
//     return (beneficiary.addr, beneficiary.name, beneficiary.isLogin, beneficiary.hasSign, beneficiary.id);
// }

// Returns the details of a Doctor for a given testator
// function getDoctorDetails(uint testatorIndex, uint doctorIndex) public view onlyTestator returns (address, string memory, bool, bool, uint) {
//     NonTestator memory doctor = testators[testatorIndex].nonTestators[doctorIndex];
//     require(doctor.userType == NonTestatorType.Doctor, "The provided index does not correspond to a Doctor");
//     return (doctor.addr, doctor.name, doctor.isLogin, doctor.hasSign, doctor.id);
// }


// alternative new code using transfer
function destroy() public onlyOwner {
    address payable recipient = payable(owner);
    recipient.transfer(address(this).balance);
}
    
    // function destroy(address apocalypse) public onlyOwner{
    //      if (apocalypse != address(0)) {
    //         selfdestruct(payable(apocalypse));
    //     } else {
    //         selfdestruct(payable(owner));
    //     }
       
    // }

	// Return owner of the smart contract
    function getOwner() public view returns (address) {
        return owner;
    }

}

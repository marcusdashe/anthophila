pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract HolographicWill {

    address private owner;
	enum NonTestatorType { Beneficiary, Doctor, Crooner }

    // Testator Details Struct
	 struct Testator {
        address addr;
        string name;
        string password;
        bool isLogin;
        bool testatorAlive; // boolean to indicate whether the testator is alive or not
		bool allNonTestatorsSigned; // boolean to indicate whether all non-testators have signed the holographic will
        string willIPFSCID; // IPFS hash of the holographic will file   
        uint id;
       
        NonTestator[] nonTestators;
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
        NonTestatorType userType; // enum that holds either beneficiary or doctor details
    }

    
    Testator[] testators;
    NonTestator[] nonTestators;

	 function getNonTestatorCount(uint testatorIndex) public view returns (uint) {
        return testators[testatorIndex].nonTestator.length;
    }

//     function getNonTestatorCount(uint testatorIndex) public view returns (uint) {
//     uint count = 0;
//     for (uint i = 0; i < nonTestators.length; i++) {
//         if (nonTestators[i].testatorAddr == testators[testatorIndex].addr) {
//             count++;
//         }
//     }
//     return count;
// }


	modifier onlyTestator() {
		bool found = false;
		for (uint i = 0; i < testators.length; i++) {
			if (testators[i].addr == msg.sender) {
				found = true;
				break;
			}
		}
    require(found, "Only logged-in testators can call this function");
    _;
}


	modifier onlyTestatorAndLogin() {
		bool found = false;
		for (uint i = 0; i < testators.length; i++) {
			if (testators[i].addr == msg.sender && testators[i].isLogin) {
				found = true;
				break;
			}
		}
    require(found, "Only logged-in testators can call this function");
    _;
}

modifier onlyBeneficiary() {
    bool found = false;
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].userType == NonTestatorType.Beneficiary && nonTestators[i].isLogin) {
            found = true;
            break;
        }
    }
    require(found, "Only logged-in Beneficiary can call this function");
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

modifier onlyCrooner() {
    bool found = false;
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].userType == NonTestatorType.Crooner && nonTestators[i].isLogin) {
            found = true;
            break;
        }
    }
    require(found, "Only logged-in crooners can call this function");
    _;
}

	
     modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _; // Continue executing the function if the modifier passes
    }

constructor() {
        owner = msg.sender; // Set the creator of the contract to be the owner       
    }

   function uploadWillIPFSCID(string memory ipfsCID) public onlyTestator {
    for (uint i = 0; i < testators.length; i++) {
        if (testators[i].addr == msg.sender && testators[i].isLogin) {
            testators[i].willIPFSCID = ipfsCID;
            break;
        }
    }
}


/* 
	This function takes in the following parameters:

	_addr: The address of the non-Testator to be added.
	_name: The name of the non-Testator to be added.
	_password: The password of the non-Testator to be added.
	_userType: An integer representing the type of non-Testator to be added, where 0 = Beneficiary, 1 = Doctor, and 2 = Crooner.
	The function then converts the _userType integer to the corresponding NonTestatorType enum value. It creates a new NonTestator struct with the given parameters and sets the isLogin and hasSign properties to false.
*/

	function addNonTestator(address _addr, string memory _name, uint _userType) public onlyTestator {
		NonTestatorType userType = NonTestatorType(_userType);
		NonTestator memory newNonTestator = NonTestator(_addr, _name, "", false, false, nonTestators.length, msg.sender, userType);
		nonTestators.push(newNonTestator);
		testators[testators.length - 1].nonTestator[getNonTestatorCount(testators.length - 1)] = newNonTestator;
		
	}


function getBeneficiaries() public view onlyTestator  returns (NonTestator[] memory) {
    uint count = getNonTestatorCount(getTestatorIndex(msg.sender));
    NonTestator[] memory beneficiaries = new NonTestator[](count);
    uint index = 0;
    for (uint i = 0; i < count; i++) {
        if (testators[getTestatorIndex(msg.sender)].nonTestator[i].userType == NonTestatorType.Beneficiary) {
            beneficiaries[index] = testators[getTestatorIndex(msg.sender)].nonTestator[i];
            index++;
        }
    }
    return beneficiaries;
}


function getDoctors() public view onlyTestator returns (NonTestator[] memory) {
    uint count = getNonTestatorCount(getTestatorIndex(msg.sender));
    NonTestator[] memory doctors = new NonTestator[](count);
    uint index = 0;
    for (uint i = 0; i < count; i++) {
        if (testators[getTestatorIndex(msg.sender)].nonTestator[i].userType == NonTestatorType.Doctor) {
            doctors[index] = testators[getTestatorIndex(msg.sender)].nonTestator[i];
            index++;
        }
    }
    return doctors;
}

function getCrooners() public view onlyTestator returns (NonTestator[] memory) {
    uint count = getNonTestatorCount(getTestatorIndex(msg.sender));
    NonTestator[] memory crooners = new NonTestator[](count);
    uint index = 0;
    for (uint i = 0; i < count; i++) {
        if (testators[getTestatorIndex(msg.sender)].nonTestator[i].userType == NonTestatorType.Crooner) {
            crooners[index] = testators[getTestatorIndex(msg.sender)].nonTestator[i];
            index++;
        }
    }
    return crooners;
}

function getTestatorIndex(address _addr) internal view returns (uint) {
    for (uint i = 0; i < testators.length; i++) {
        if (testators[i].addr == _addr && testators[i].isLogin) {
            return i;
        }
    }
    revert("Testator not found");
}

function deleteNonTestator(address nonTestatorAddr) public onlyTestator {
    for (uint i = 0; i < testators.length; i++) {
        if (testators[i].addr == msg.sender && testators[i].isLogin) {
            for (uint j = 0; j < testators[i].nonTestator.length; j++) {
                if (testators[i].nonTestator[j].addr == nonTestatorAddr) {
                    delete testators[i].nonTestator[j];
                    break;
                }
            }
            break;
        }
    }
}



	function registerTestator(string memory _name, string memory _password) public returns (uint) {
    // Create new testator and add to the testators array
    Testator memory newTestator = Testator({
        addr: msg.sender,
        name: _name,
        password: _password,
        isLogin: false,
        testatorAlive: true,
        allNonTestatorsSigned: false,
        willIPFSCID: "",
        id: testators.length
    });
    testators.push(newTestator);
	return newTestator.id;
}


 function signin(string memory _testatorPassword) public onlyTestator returns (bool) {
	 	for (uint i = 0; i < testators.length; i++) {
			if (testators[i].addr == msg.sender) {
				if (keccak256(bytes(testators[i].password)) == keccak256(bytes(_testatorPassword))) {
					testators[i].isLogin = true;
					return true;
				} else {
					return false;
			}
		}
		return false;
    }
 }

   function beneficiarySignup(string memory _name, string memory _password) public onlyBeneficiary{
    NonTestator memory newBeneficiary = NonTestator(msg.sender, _name, _password, true, false, nonTestators.length, address(0), NonTestatorType.Beneficiary);
    nonTestators.push(newBeneficiary);
}

function doctorSignup(string memory _name, string memory _password) public onlyDoctor{
    NonTestator memory newDoctor = NonTestator(msg.sender, _name, _password, true, false, nonTestators.length, address(0), NonTestatorType.Doctor);
    nonTestators.push(newDoctor);
}

function croonerSignup(string memory _name, string memory _password) public onlyCrooner{
    NonTestator memory newCrooner = NonTestator(msg.sender, _name, _password, true, false, nonTestators.length, address(0), NonTestatorType.Crooner);
    nonTestators.push(newCrooner);
}


function beneficiarySignin(string memory _password) public onlyBeneficiary{
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].password == _password && nonTestators[i].userType == NonTestatorType.Beneficiary) {
            nonTestators[i].isLogin = true;
            break;
        }
    }
}

function croonerSignin(string memory _password) public onlyCrooner{
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].password == _password && nonTestators[i].userType == NonTestatorType.Crooner) {
            nonTestators[i].isLogin = true;
            break;
        }
    }
}

function doctorsSignin(string memory _password) public onlyDoctor{
    for (uint i = 0; i < nonTestators.length; i++) {
        if (nonTestators[i].addr == msg.sender && nonTestators[i].password == _password && nonTestators[i].userType == NonTestatorType.Doctor) {
            nonTestators[i].isLogin = true;
            break;
        }
    }
}


function declareDeath() public {
    bool found = false;
    for (uint i = 0; i < nonTestators.length; i++) {
        if ((nonTestators[i].addr == msg.sender && nonTestators[i].userType == NonTestatorType.Doctor && nonTestators[i].isLogin) ||
            (nonTestators[i].addr == msg.sender && nonTestators[i].userType == NonTestatorType.Crooner && nonTestators[i].isLogin)) {
            found = true;
            break;
        }
    }
    require(found, "Only logged-in doctors or crooners can declare death");
    for (uint i = 0; i < testators.length; i++) {
        if (testators[i].addr == nonTestators[nonTestators.length - 1].testatorAddr) {
            testators[i].testatorAlive = false;
            break;
        }
    }
}

function coSignWill() public onlyBeneficiary onlyDoctor onlyCrooner {
    uint testatorIndex = getTestatorIndex(msg.sender);
    uint count = getNonTestatorCount(testatorIndex);
    for (uint i = 0; i < count; i++) {
        if (testators[testatorIndex].nonTestator[i].userType == NonTestatorType.Beneficiary && !testators[testatorIndex].nonTestator[i].hasSign) {
            testators[testatorIndex].nonTestator[i].hasSign = true;
        }
    }
}

function haveAllNonTestatorsSigned(address testatorAddress) public view returns(bool) {
    for (uint i = 0; i < testators.length; i++) {
        if (testators[i].addr == testatorAddress) {
            uint nonTestatorCount = testators[i].nonTestator.length;
            for (uint j = 0; j < nonTestatorCount; j++) {
                if (!testators[i].nonTestator[j].hasSign) {
                    return false;
                }
            }
            return true;
        }
    }
    return false;
}


function revealWillIPFSCID() public onlyBeneficiary {
    bool allNonTestatorsSigned = true;
    uint testatorIndex;

    // Find the testator that the beneficiary is added to
    for (uint i = 0; i < testators.length; i++) {
        for (uint j = 0; j < testators[i].nonTestator.length; j++) {
            if (testators[i].nonTestator[j].addr == msg.sender && testators[i].nonTestator[j].userType == NonTestatorType.Beneficiary) {
                testatorIndex = i;
                break;
            }
        }
    }

    // Check if all non-Testators have signed
    for (uint i = 0; i < testators[testatorIndex].nonTestator.length; i++) {
        if (testators[testatorIndex].nonTestator[i].hasSign == false) {
            allNonTestatorsSigned = false;
            break;
        }
    }

 // Check if the testator is declared dead
    if (allNonTestatorsSigned && !testators[testatorIndex].testatorAlive) {
        // Return the IPFS Hash CID of the holographic will
        string memory ipfsCID = testators[testatorIndex].willIPFSCID;
        return ipfsCID;
    }
}


	
	// Returns the details of a Beneficiary for a given testator
function getBeneficiaryDetails(uint testatorIndex, uint beneficiaryIndex) public view onlyTestator returns (address, string memory, bool, bool, uint) {
    NonTestator memory beneficiary = testators[testatorIndex].nonTestator[beneficiaryIndex];
    require(beneficiary.userType == NonTestatorType.Beneficiary, "The provided index does not correspond to a Beneficiary");
    return (beneficiary.addr, beneficiary.name, beneficiary.isLogin, beneficiary.hasSign, beneficiary.id);
}

// Returns the details of a Doctor for a given testator
function getDoctorDetails(uint testatorIndex, uint doctorIndex) public view onlyTestator returns (address, string memory, bool, bool, uint) {
    NonTestator memory doctor = testators[testatorIndex].nonTestator[doctorIndex];
    require(doctor.userType == NonTestatorType.Doctor, "The provided index does not correspond to a Doctor");
    return (doctor.addr, doctor.name, doctor.isLogin, doctor.hasSign, doctor.id);
}

// Returns the details of a Crooner for a given testator
function getCroonerDetails(uint testatorIndex, uint croonerIndex) public view onlyTestator returns (address, string memory, bool, bool, uint) {
    NonTestator memory crooner = testators[testatorIndex].nonTestator[croonerIndex];
    require(crooner.userType == NonTestatorType.Crooner, "The provided index does not correspond to a Crooner");
    return (crooner.addr, crooner.name, crooner.isLogin, crooner.hasSign, crooner.id);
}
    
    function destroy(address apocalypse) public onlyOwner{
         if (apocalypse != address(0)) {
            selfdestruct(payable(apocalypse));
        } else {
            selfdestruct(payable(owner));
        }
       
    }

	// Return owner of the smart contract
    function getOwner() public view returns (address) {
        return owner;
    }

}

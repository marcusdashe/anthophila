pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract HolographicWill {

     address private owner;

    // address of the testator
    struct TestatorDetails {
        address addr;
        string name;
        string password;
        bool isUserLoggedIn;
        bool testatorAlive; // boolean to indicate whether the testator is alive or not
        string willEncoded; // IPFS hash of the holographic will file   
        uint id;
    }

    struct UserDetails {
        address addr;
        string name;
        string password;
        bool isUserLoggedIn;
        bool beneficiarySigned;
        uint number;
    }

    TestatorDetails[] testators;
    UserDetails[] allBeneficiaries;
    UserDetails doctor;

    mapping(address => uint) BeneficiaryNumbers;
    mapping(address => uint) Testator2IdMapping;
 
    mapping (address => bool) public EligibleAddresses;


    modifier onlyTestator(){
        require(testators[Testator2IdMapping[msg.sender]].isUserLoggedIn == true, "User not logged in");

        _;
    }

    modifier onlyDoctor(){
        require(doctor.isUserLoggedIn == true, "User not logged in");
        require(doctor.addr == msg.sender, "Ownership Assertion: Caller is not the owner");
        _;
    }

    modifier testatorIsNotAlive(){
        require(testators[Testator2IdMapping[msg.sender]].testatorAlive == false, "Testator is deceased, cannot sign the will.");
        _;
    }

    modifier isBeneficiaryAddress(address _address){
        uint _number = BeneficiaryNumbers[_address];
        require(allBeneficiaries[_number].isUserLoggedIn == true, "User not logged in");        
        require(EligibleAddresses[msg.sender] == true, "Caller is not a Beneficiary, cannot sign the will.");
        _;
        
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _; // Continue executing the function if the modifier passes
    }

    constructor(string memory _testatorName, string memory _password ) {

        owner = msg.sender; // Set the creator of the contract to be the owner
       
    }

    function uploadWill(string memory _base64) public onlyTestator() {
        willEncoded = _base64;
        
    }

// Return owner of the smart contract
    function getOwner() public view returns (address) {
        return owner;
    }

    function addBeneficiary(address _beneficiaryAddr, string memory _beneficiaryName) public onlyTestator() {
        require(testators.isUserLoggedIn == true, "User not logged in");
        uint _number = allBeneficiaries.length; // index of the new struct of the beneficiary to be added

        allBeneficiaries.push(UserDetails ({
        addr: _beneficiaryAddr,
        name: _beneficiaryName,
        password: "",
        isUserLoggedIn: false,
        beneficiarySigned: false,
        number: _number
    }));
        EligibleAddresses[_beneficiaryAddr]= true;
        BeneficiaryNumbers[_beneficiaryAddr] = _number;
    }

    function addDoctor(address _beneficiaryAddr, string memory _doctorName) public onlyTestator() {
        doctor.addr = _beneficiaryAddr;
        doctor.name = _doctorName;
        doctor.password = "";
        doctor.isUserLoggedIn = false;
        doctor.beneficiarySigned = false; // permanently false since the doctor is not a beneficiary
        doctor.number = 0; // value does not matter as the doctor is not part of the beneficiaries array 
    }

    function viewBeneficiaries() public view returns (UserDetails[] memory) {
        return allBeneficiaries;
    }

    function viewDoctor() public view returns (UserDetails memory) {
        return doctor;
    }

    function viewTestator() public view returns (TestatorDetails memory) {
        return testators[Testator2IdMapping[msg.sender]];
    }

    function deleteBeneficiary(address _beneficiaryAddr) public onlyTestator() {
        require(EligibleAddresses[_beneficiaryAddr] == true, "Address is not a Beneficiary");// check if address is a beneficiary

        uint _number = BeneficiaryNumbers[_beneficiaryAddr];
        if (_number < allBeneficiaries.length - 1) {

        for(uint i = _number; i < allBeneficiaries.length; i++){
        allBeneficiaries[_number] = allBeneficiaries[_number + 1]; 
        allBeneficiaries[_number].number = _number;
        }

        allBeneficiaries.pop();
        EligibleAddresses[_beneficiaryAddr]= false;
        delete BeneficiaryNumbers[_beneficiaryAddr];
        }
        else if (_number == allBeneficiaries.length - 1) {
            allBeneficiaries.pop();
            EligibleAddresses[_beneficiaryAddr]= false;
            delete BeneficiaryNumbers[_beneficiaryAddr];
        }
    }

    function signupAsTestator(address _address, string memory _name, string memory _password) public returns (bool){
        require(_address != address(0), "Invalid address");

        TestatorDetails memory newTestator = TestatorDetails({
            addr: _address,
            name: _name,
            password: _password,
            isUserLoggedIn: false,
            testatorAlive: true,
            id : testators.length
        });

            Testator2IdMapping[_address] = testators.length;

            testators.push(newTestator);       
            return true;
    }

    function signupAsBeneficiary(
        address _address,
        string memory _name,
        string memory _password
    ) public returns (bool){
        uint _number = BeneficiaryNumbers[_address];
        require(_address != address(0), "Invalid address");
        require(allBeneficiaries[_number].addr == _address, "Invalid address");

        allBeneficiaries[_number].name = _name;
        allBeneficiaries[_number].password = _password;
        return true;
    }

    function signupAsDoctor(
        address _address,
        string memory _name,
        string memory _password
    ) public returns (bool){
        require(_address != address(0), "Invalid address");
        require(doctor.addr == _address, "Invalid address");

        doctor.name = _name;
        doctor.password = _password;
        return true;
    }

    function loginAsTestator(address _address, string memory _password) public returns (bool){
        require(testators[Testator2IdMapping[msg.sender]].addr == _address, "User not registered");
        require(!testators[Testator2IdMapping[msg.sender]].isUserLoggedIn, "User already logged in");

        if(keccak256(abi.encodePacked(testators[Testator2IdMapping[msg.sender]].password, _address)) == keccak256(abi.encodePacked(_password, _address))){
            testators[Testator2IdMapping[msg.sender]].isUserLoggedIn = true;
            return true;
        } else {
            return false;
        }
    }


    function loginAsBeneficiary(address _address, string memory _password) public returns (bool){
        uint _number = BeneficiaryNumbers[_address];
        require(allBeneficiaries[_number].addr == _address, "User not registered");
        require(!allBeneficiaries[_number].isUserLoggedIn, "User already logged in");

        if(keccak256(abi.encodePacked(allBeneficiaries[_number].password, _address)) == keccak256(abi.encodePacked(_password, _address))){
            allBeneficiaries[_number].isUserLoggedIn = true;
            return true;
        } else {
            return false;
        }
    }

    function loginAsDoctor(address _address, string memory _password) public returns (bool){

        require(doctor.addr == _address, "User not registered");
        require(!doctor.isUserLoggedIn, "User already logged in");

        if(keccak256(abi.encodePacked(doctor.password, _address)) == keccak256(abi.encodePacked(_password, _address))){
            doctor.isUserLoggedIn = true;
            return true;
        } else {
            return false;
        }
    }

    function logoutTestator() public onlyTestator() {
        require(testators[].isUserLoggedIn, "User not logged in");

        testators[Testator2IdMapping[msg.sender]].isUserLoggedIn = false;
    }

    function logoutBeneficiary(address _address) public isBeneficiaryAddress(_address) {
        uint _number = BeneficiaryNumbers[_address];
        require(allBeneficiaries[_number].isUserLoggedIn, "User not logged in");

        allBeneficiaries[_number].isUserLoggedIn = false;
    }

    function logoutDoctor() public onlyTestator() {
        require(doctor.isUserLoggedIn, "User not logged in");

        doctor.isUserLoggedIn = false;
    }

    function declareDeath(address _testatorAddress) public onlyDoctor returns(bool) {
        testators[Testator2IdMapping[_testatorAddress]].testatorAlive = false;
        return true;
    }

    function signWill(address _beneficiaryAddr) public testatorIsNotAlive() isBeneficiaryAddress(_beneficiaryAddr) {
        uint _number = BeneficiaryNumbers[_beneficiaryAddr];
        allBeneficiaries[_number].beneficiarySigned = true;
    }
    
    function checkAllSigned() private view returns (bool) {
        for (uint i = 0; i < allBeneficiaries.length; i++) {
            if (!allBeneficiaries[i].beneficiarySigned) {
                return false;
            }
        }
        return true;
    }
    
    function getEncodedWill(address _address) public view isBeneficiaryAddress(_address) returns (string memory) {
        require(testators[Testator2IdMapping[_address]].testatorAlive == false, "Testator is still alive, cannot reveal the will.");
        require(checkAllSigned(), "All beneficiaries must sign the will before the CID is revealed.");
        return testators[Testator2IdMapping[msg.sender]].willEncoded;
    }
    
    function destroy(address apocalypse) public onlyOwner{
         if (apocalypse != address(0)) {
            selfdestruct(payable(apocalypse));
        } else {
            selfdestruct(payable(owner));
        }
       
    }

}

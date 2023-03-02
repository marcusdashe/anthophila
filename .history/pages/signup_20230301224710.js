import React from 'react'
import Button from '../components/Button'
import Web3 from 'web3'



const Signup = () => {

  async function requestAccounts() {
    if (window.ethereum) {
      await window.ethereum.request({ method: 'eth_requestAccounts' });
      const web3 = new Web3(window.ethereum);
      return web3;
    } else {
      alert('Please install Metamask to use this dApp');
    }
  }

  return (
    <div className="flex flex-col items-center justify-center h-screen bg-gray-100">
      <div className='font-bold text-2xl cursor-pointer flex flex-col items-center text-gray-80 hover:scale-110 duration-500 mb-6'>
            <img src="/assets/logo.png" alt="logo" className="object-scale-down h-20 w-20" />
                <span className='text-2xl text-[#492823] mr-1 pt-2 '>
                    Anthophila
                </span>
      </div>
    <div className="bg-white p-10 rounded-lg shadow-lg">
      <h1 className="text-2xl font-medium mb-4">Create an account</h1>
      <form>
        <div className="mb-4">
          <label htmlFor="name" className="block text-gray-700 font-medium mb-2">Full Name</label>
          <input type="text" id="name" name="name" className="border-[#5F3EB2] border-2 rounded-lg py-2 px-3 w-full" />
        </div>
        <div className="mb-4">
          <label htmlFor="password" className="block text-gray-700 font-medium mb-2">Password</label>
          <input type="password" id="password" name="password" className="border-[#5F3EB2] border-2 rounded-lg py-2 px-3 w-full" />
        </div>
        <Button isPrimary={true} onClick={requestAccounts}>Sign up</Button>
      </form>
    </div>
  </div>
);
}



export default Signup
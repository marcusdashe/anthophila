import React, {useState} from 'react'
import Button from '../components/Button'
import Web3 from 'web3'



const Signup = () => {
  const [ error, setError ] = useState("")
  const [web3, setWeb3] = useState(null);
  const router = useRouter()
  const signinAs = router.query
  

  const connectWalletHandler = async (evt) => {      
        evt.preventDefault()
        console.log("Button clicked");
          if(typeof window !== "undefined" && window.ethereum !== "undefined"){
            console.log("Metamask detected");
             try{
                 await window.ethereum.request({method: "eth_requestAccounts"})
                 console.log("Metamask accounts requested");
                 setWeb3(new Web3(window.ethereum));
             } catch(error){
                  setError(error.message)
             }
              
          } else {
              window.alert("Please install metamask")
          }
          if (web3) {
            // Use web3 to interact with the blockchain
            console.log(web3)
            console.log("Connected succesfully")
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
       
        <button onClick = {connectWalletHandler} className="bg-[#492823] w-150 text-white py-2 px-6 rounded-2xl md:mr-3 ml-0 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500 hover:scale-110 duration-500  snm:mr-3">Sign up</button>
      </form>
    </div>
  </div>
);
}



export default Signup
import React, {useEffect} from 'react'

const Button = ({isPrimary, children}) => {
 console.log(isPrimary)
  return (
    <>
    {
      isPrimary ?  
      <button className="bg-[#492823] w-150 text-white py-2 px-6 rounded-2xl md:mr-3 ml-0 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500 hover:scale-125  snm:mr-3">
        {children}
      </button> 
    : 
      <button className="bg-white w-150 text-[#5F3EB2]  border-[3px] border-[#5F3EB2] font-bold py-2 px-6 rounded-2xl md:ml-8 hover:bg-[#D5D0ED] duration-500 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500">
        {children}
      </button>
    
    }
   </>
  )
}
// bg-[] w-150 text-white py-2 px-6 rounded-2xl md:ml-8 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500

export default Button
import React, {useEffect} from 'react'

const Button = ({isPrimary, children}) => {
 console.log(isPrimary)
  return (
    <button className=" w-150 text-white py-2 px-6 rounded-2xl md:ml-8 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500">
        {children}
    </button>
  )
}
// bg-[] w-150 text-white py-2 px-6 rounded-2xl md:ml-8 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500

export default Button
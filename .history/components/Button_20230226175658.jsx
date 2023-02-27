import React from 'react'

const Button = (props) => {
  return (
    <button className='bg-[#492823] w-150 mr-5 text-white py-2 px-5 rounded-2xl md:ml-8 hover:bg-[#F5F1F3] hover:text-[#492823] duration-500'>
        {props.children}
    </button>
  )
}

export default Button
import React from 'react'

const Button = (props) => {
  return (
    <button className='bg-[{props.bg}] w-150 text-white py-2 px-6 rounded-2xl md:ml-8 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500'>
        {props.children}
    </button>
  )
}

export default Button
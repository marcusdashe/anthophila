import React from 'react'

const Button = (props) => {
  return (
    <button className='bg-indigo-600 w-150 text-white py-2 px-6 rounded-2xl md:ml-8 hover:bg-gray-400 duration-500'>
        {props.children}
    </button>
  )
}

export default Button
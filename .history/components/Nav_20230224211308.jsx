import React from 'react'
import Button from './Button'

export const Nav = () => {
  let Links = [
    { name: "HOME", link: "/"},
    { name: "ABOUT", link: "/about"},
    { name: "CONTACT US", link: "/contact"},
    { name: "TEAM", link: "/team"},
  ]
  return (
    <div className='shadow-md w-full fixed top-0 left-0'>
        <div className='md:flex items-center justify-between bg-white py-4 md:px-10 px-7'>
            <div className='font-bold text-2xl cursor-pointer flex items-center text-gray-80'>
                <span className='text-3xl text-[#492823] mr-1 pt-2'>
                    Anthophila
                </span>
            </div>
            <ul className='md:flex md:items-center md:pb-0 pb-12 absolute md:static bg-white md:z-auto z-[-1] left-0 w-full md:w-auto md:p1-0 p1-9 transition-all duration-500'>
              { Links.map((link, idx) => (
                <li key={link.name} className='md:ml-8 text-md font-bold md:my-0 my-7'>
                    <a href={link.link} key={idx} className="text-[#492823] hover:text-gray-400 duration-500">{link.name}</a>
                </li>
              ))}
              <Button>Sign in</Button>
              <Button>Sign up</Button>
            </ul>
        </div>
    </div>
  )
}

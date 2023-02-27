import React from 'react'

export const Nav = () => {
  let Links = [
    { name: "HOME", link: "/"},
    { name: "SERVICE", link: "/service"},
    { name: "ABOUT", link: "/about"},
    { name: "BLOG", link: "/blog"},
    { name: "CONTACT", link: "/contact"},
  ]
  return (
    <div className='shadow-md w-full fixed top-0 left-0'>
        <div className='md:flex items-center justify-between bg-white py-4 md:px-10 px-7'>
            <div className='font-bold text-2xl cursor-pointer flex items-center text-gray-80'>
                <span className='text-3xl text-indigo-600 mr-1 pt-2'>
                    CryptoWill
                </span>
            </div>
            <ul className='md:flex md:items-center'>
              { Links.map((link, idx) => (
                <li className='md:ml-8 text-md font-bold'>
                    <a href={link.link} id={idx}>{link.name}</a>
                </li>
              ))}
            </ul>
        </div>
    </div>
  )
}

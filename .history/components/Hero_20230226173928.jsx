import React from 'react'

const Hero = () => {
  return (
        <div className='h-screen outline'>
  
            <header className="h-screen flex justify-center items-center">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col items-center justify-center h-screen">
                <h1 className="text-5xl font-bold text-[#2D2926] text-center mb-4">Keep your will safe and secure</h1>
                <p className='text-center'>Store them with us</p>
            </div>
            </header>
            <p>Login As</p>
            <button>Testator</button> <button>Beneficiary</button>
        </div>
   
  )
}

export default Hero
import React from 'react'
import Button from './Button'

const Hero = () => {
  return (
        <div className='h-screen flex justify-center items-center flex-col'>
  
            <header className="">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col items-center justify-center">
                <h1 className="text-5xl font-bold text-[#2D2926] text-center mb-4">Keep your will safe and secure</h1>
                <p className='text-center text-2xl'>Store them with us</p>
            </div>
            </header>
            <section className='border-4 border-solid border-sky flex justify-center items-center flex-col mt-20'>
               <p>Login As</p>
                <div><Button>Testator</Button> <Button>Beneficiary</Button> </div>
            </section>
            
        </div>
   
  )
}

export default Hero
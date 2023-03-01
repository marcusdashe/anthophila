import React from 'react'
import Button from './Button'

const Hero = () => {
  return (
        <div className='h-screen flex justify-center items-center flex-col'>
  
            <header className="">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col items-center justify-center">
                <h1 className="text-5xl font-bold text-[#D5D0ED] text-center mb-4">Keep your <span className='text-[#2D2926]'>will</span> safe and secure</h1>
                <p className='text-center text-2xl'>Store them with us</p>
            </div>
            </header>
            <section className='outline w-100 flex justify-center items-center flex-col mt-20'>
               <p className='font-bold'>Login As</p>
                <div className='mt-7'><Button isPrimary={true}>Testator</Button> <Button isPrimary={false}>Beneficiary</Button> </div>
            </section>
            
        </div>
   
  )
}

export default Hero
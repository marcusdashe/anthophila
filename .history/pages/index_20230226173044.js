import Head from 'next/head'
import Image from 'next/image'
import { Inter } from '@next/font/google'
import styles from '@/styles/Home.module.css'
import { Nav } from '@/components/Nav'
import Hero from '@/components/Hero'

const inter = Inter({ subsets: ['latin'] })

export default function Home() {
  return (
    <>
      <Head>
        <title>Anthophilia</title>
        <meta name="description" content="decentralized platform for storing will" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav />
     
      <main className="w-full h-screen bg-cover bg-no-repeat bg-center bg-fixed" style={{backgroundImage: "url('/assets/bg-vintage.png')"}}>
      
      <Hero />
     
      </main>
    </>
  )
}

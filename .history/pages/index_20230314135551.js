import Head from "next/head";
import Image from "next/image";
import { Inter } from "@next/font/google";
import styles from "@/styles/Home.module.css";
import Hero from "@/components/Hero";
import Layout from "@/components/Layout";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  return (
    <Layout>
      {/* <main className="w-full h-screen bg-cover bg-no-repeat bg-center bg-fixed" style={{backgroundImage: "url('/assets/bg-vintage.png')"}}> */}
      {/* <main className="w-full h-screen"> */}
      <Hero />
      {/* </main> */}
    </Layout>
  );
}

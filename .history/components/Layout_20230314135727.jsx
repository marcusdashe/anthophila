import React from "react";
import Head from "next/head";
import { Nav } from "@/components/Nav";

const Layout = ({ children }) => {
  return (
    <div className="flex flex-col min-h-screen">
      <Head>
        <title>Anthophilia</title>
        <meta
          name="description"
          content="decentralized platform for storing will"
        />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav />

      <main className="flex-grow mb-10">{children}</main>

      <footer className="bg-gray-800 py-4 text-gray-400 text-center">
        &copy; 2023 Anthophila Inc.
      </footer>
    </div>
  );
};

export default Layout;

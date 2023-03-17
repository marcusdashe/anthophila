import React from "react";

const Layout = ({ children }) => {
  return (
    <div className="flex flex-col min-h-screen">
      <Head>
        <title>Anthophila</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav />

      <main className="flex-grow">{children}</main>

      <footer className="bg-gray-800 py-4 text-gray-400 text-center">
        &copy; 2023 Holographic Will Dashboard
      </footer>
    </div>
  );
};

export default Layout;

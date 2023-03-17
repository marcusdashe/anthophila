import React from "react";

const Layout = ({ children }) => {
  return (
    <div className="flex flex-col min-h-screen">
      <Head>
        <title>Anthophila</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
    </div>
  );
};

export default Layout;

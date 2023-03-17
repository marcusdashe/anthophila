import React, { useState, useEffect } from "react";
import { useRouter } from "next/router";
import Web3 from "web3";
import KeyboardBackspaceIcon from "@mui/icons-material/KeyboardBackspace";
import Link from "next/link";
import Layout from "@/components/Layout";

const Signin = () => {
  const [error, setError] = useState("");
  const [web3, setWeb3] = useState(null);
  const [password, setPassword] = useState("");
  const [ethaddress, setEthaddress] = useState("");
  const [signupAs, setSignupAs] = useState("");

  const router = useRouter();

  const callSignupFunctionOnSC = async (evt) => {
    evt.preventDefault();
    await connectWallet();
  };

  const connectWallet = async (evt) => {
    if (typeof window !== "undefined" && window.ethereum !== "undefined") {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        setWeb3(new Web3(window.ethereum));
      } catch (error) {
        setError(error.message);
      }
    } else {
      window.alert("Please install metamask");
    }
    if (web3) {
      // Use web3 to interact with the blockchain
      setEthaddress(ethereum.selectedAddress);
    }
  };
  return (
    <Layout>
      <div className="flex flex-col items-center justify-center h-screen bg-gray-100">
        <figure className="fixed top-10 left-10">
          <Link href="/">
            {" "}
            <KeyboardBackspaceIcon fontSize="large" />
          </Link>
        </figure>
        <div className="font-bold text-2xl cursor-pointer flex flex-col items-center text-gray-80 hover:scale-110 duration-500 mb-6">
          <img
            src="/assets/logo.png"
            alt="logo"
            className="object-scale-down h-20 w-20"
          />
          <span className="text-2xl text-[#492823] mr-1 pt-2 ">Anthophila</span>
        </div>
        <div className="bg-white p-10 rounded-lg shadow-lg">
          <h1 className="text-2xl font-medium mb-4">Login</h1>
          <form onSubmit={callSignupFunctionOnSC}>
            <div className="mb-4">
              <label
                htmlFor="password"
                className="block text-gray-700 font-medium mb-2"
              >
                Password
              </label>
              <input
                type="password"
                id="password"
                name="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="border-[#5F3EB2] border-2 rounded-lg py-2 px-3 w-full"
              />
            </div>
            <label htmlFor="signupAs">Signin as</label>
            <select
              id="signupAs"
              value={signupAs}
              onChange={(e) => setSignupAs(e.target.value)}
              className="border-1 mx-3 rounded-md p-1 focus:outline-none focus:ring-2 focus:ring-[#492823]"
              required
            >
              <option value="">-- Select --</option>
              <option value="testator">Testator</option>
              <option value="beneficiary">Beneficiary</option>
              <option value="doctor">Doctor/Coroner</option>
            </select>

            <button className="bg-[#492823] w-150 text-white my-4 py-2 px-6 rounded-2xl md:mr-3 ml-0 hover:bg-[#D5D0ED] hover:text-[#492823] duration-500 hover:scale-110 duration-500  snm:mr-3">
              Sign in
            </button>
          </form>
        </div>
        <p className="text-[#FBE7EE] w-[30%] my-10">{error}</p>
        <p className="text-[#caa5b2] w-[30%] my-10">
          Login usin with this Ethereum Address: {ethaddress}
        </p>
      </div>
    </Layout>
  );
};

export default Signin;

import React, { useState } from "react";
import Link from "next/link";
import Button from "./Button";
import MenuIcon from "@mui/icons-material/Menu";
import CloseIcon from "@mui/icons-material/Close";

export const Nav = () => {
  let Links = [
    { name: "HOME", link: "/" },
    { name: "HOW IT WORKS", link: "/hiw" },
    { name: "CONTACT US", link: "/contact" },
    { name: "TEAM", link: "/team" },
    { name: "FAQ", link: "/faq" },
  ];
  let [open, setOpen] = useState(false);

  return (
    <div className="md:fixed bg-white bg-opacity-[0.8] backdrop-blur-lg lg:fixed z-50 shadow-md w-full fixed top-0 left-0">
      <div className="md:flex items-center justify-between bg-white py-4 md:px-10 px-7">
        <Link href={"/"}>
          <div className="font-bold text-2xl cursor-pointer flex items-center text-gray-80 hover:scale-110 duration-500">
            <img
              src="/assets/logo.png"
              alt="logo"
              className="object-scale-down h-50 w-20"
            />
            <span className="text-3xl text-[#492823] mr-1 pt-2 ">
              Anthophila
            </span>
          </div>
        </Link>

        <div
          onClick={() => setOpen(!open)}
          className="text-3xl absolute right-8 top-6 cursor-pointer md:hidden "
        >
          {open ? (
            <CloseIcon fontSize="large" />
          ) : (
            <MenuIcon fontSize="large" />
          )}
        </div>
        <ul
          className={`md:flex md:items-center md:pb-0 pb-12 absolute md:static bg-white md:z-auto z-[-1] left-0 w-full md:w-auto md:pl-0 pl-9 transition-all duration-500 ease-in ${
            open ? "top-20 opacity-100" : "top-[-490px]"
          } md:opacity-100 opacity-0`}
        >
          {Links.map((link, idx) => (
            <li
              key={link.name}
              className="md:ml-8 text-md font-bold md:my-0 my-7 hover:scale-110 duration-500"
            >
              <Link
                href={link.link}
                key={idx}
                className="text-[#492823] hover:text-[#5F3EB2] duration-500 mr-3 "
              >
                {link.name}
              </Link>
            </li>
          ))}
          <Button isPrimary={true}>
            <Link href={{ pathname: "/signinOption" }}> Sign in </Link>
          </Button>
          <Button isPrimary={false}>
            <Link href={"/signup"}>Sign up</Link>
          </Button>
        </ul>
      </div>
    </div>
  );
};

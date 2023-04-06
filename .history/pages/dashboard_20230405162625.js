import React, { useState } from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import SearchIcon from "@mui/icons-material/Search";
import DashboardIcon from "@mui/icons-material/Dashboard";

const Dashboard = () => {
  const [open, setOpen] = useState(true);

  const Menus = [
    { title: "Dashboard" },
    { title: "Pages" },
    { title: "Media", spacing: true },
    {
      title: "Projects",
      submenu: true,
      submenuItems: [
        { title: "Submenu 1" },
        { title: "Submenu 2" },
        { title: "Submenu 3" },
      ],
    },
    { title: "Analytics" },
    { title: "Inbox" },
    { title: "Profile", spacing: true },
    { title: "Setting" },
    { title: "Logout" },
  ];

  return (
    <div className="flex">
      <div
        className={`bg-gray-800 h-screen p-5 pt-8 ${
          open ? "w-72" : "w-[125px]"
        } relative duration-300`}
        onClick={() => setOpen(!open)}
      >
        <ArrowBackIcon
          fontSize="small"
          onClick={() => setOpen(!open)}
          className={`bg-white text-[#AE1B1B] text-3xl mt-5 
                                rounded-full absolute -right-3 top-10 
                                cursor-pointer ${
                                  !open && "rotate-180"
                                } duration-300 border border-[#AE1B1B]`}
        />
        <div className="inline-flex items-center text-white">
          <img
            src="/assets/logo.png"
            alt="logo"
            className={`object-scale-down mr-2 h-20 w-20 
                        bg-white rounded-full text-2xl 
                        cursor-pointer block float-left duration-500 ${
                          open && "rotate-[360deg]"
                        }`}
          />
          <h1
            className={`text-white origin-left font-medium ml-4 text-2xl duration-300 ${
              !open && "scale-0"
            }`}
          >
            Anthophila
          </h1>
        </div>
        <div
          onClick={() => setOpen(!open)}
          className={`flex items-center rounded-md bg-white bg-opacity-60 mt-6 ${
            !open ? "px-2.5" : "px-4"
          } py-2`}
        >
          <SearchIcon
            onClick={() => setOpen(!open)}
            fontSize="small"
            className={`text-black  text-md block float-left cursor-left ${
              open && "mr-2"
            }`}
          />
          <input
            type={"search"}
            placeholder={"Search"}
            onClick={() => setOpen(!open)}
            className={`text-base bg-transparent w-full text-white focus:outline-none pl-2 ${
              !open && "hidden"
            }`}
          />
        </div>

        <ul className=" pt-2">
          {Menus.map((menu, index) => (
            <>
              <li
                key={index}
                className={`text-gray-300 
                text-small flex 
                items-center gap-x-4 cursor-pointer rounded p-2
                 hover:bg-white hover:text-black duration-300 
                 bg-opacity-100  ${menu.spacing ? "mt-7" : "mt-2"}`}
              >
                <span className="text-2xl block float-left">
                  <DashboardIcon />
                </span>
                <span
                  className={`text-base font-medium flex-1 duration-500 ${
                    !open && "hidden"
                  }`}
                >
                  {menu.title}
                </span>
              </li>
            </>
          ))}
        </ul>
      </div>

      <div className="p-7">
        <h1 className="text-2xl font-semibold"> Home Page</h1>
      </div>
    </div>
  );
};

export default Dashboard;

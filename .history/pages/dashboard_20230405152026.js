import React, { useState } from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import SearchIcon from "@mui/icons-material/Search";

const Dashboard = () => {
  const [open, setOpen] = useState(true);
  return (
    <div className="flex">
      <div
        className={`bg-gray-800 h-screen p-5 pt-8 ${
          open ? "w-72" : "w-[120px]"
        } relative duration-300`}
      >
        <ArrowBackIcon
          fontSize="small"
          onClick={() => setOpen(!open)}
          className={`bg-white text-[#AE1B1B] text-3xl 
                                rounded-full absolute -right-3 top-10 
                                cursor-pointer ${
                                  !open && "rotate-180"
                                } duration-300 border border-[#AE1B1B]`}
        />
        <div className="inline-flex items-center text-white">
          <img
            src="/assets/logo.png"
            alt="logo"
            className={`object-scale-down mr-2 h-50 w-20 
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
        <div className="flex items-center rounded-md bg-smoke-50 mt-6 px-4 py-2">
          <SearchIcon
            fontSize="small"
            className="text-black  text-md block float-left cursor-left"
          />
          <input type={"search"} className="" />
        </div>
      </div>

      <div className="p-7">
        <h1 className="text-2xl font-semibold"> Home Page</h1>
      </div>
    </div>
  );
};

export default Dashboard;

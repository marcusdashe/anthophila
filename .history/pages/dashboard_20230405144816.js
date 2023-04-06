import React, { useState } from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";

const Dashboard = () => {
  const [open, setOpen] = useState(true);
  return (
    <div className="flex">
      <div
        className={`bg-gray-800 h-screen p-5 pt-8 ${
          open ? "w-72" : "w-20"
        } relative duration-300`}
      >
        <ArrowBackIcon
          onClick={() => setOpen(!open)}
          className={`bg-white text-purple-900 text-3xl 
                                rounded-full absolute -right-3 top-9 
                                cursor-pointer ${
                                  !open && "rotate-180"
                                } duration-300 border border-purple-800`}
        />
        <div className="inline-flex text-white">
          <img
            src="/assets/logo.png"
            alt="logo"
            className="object-scale-down h-50 w-20 bg-white rounded-full"
          />
        </div>
      </div>

      <div className="p-7">
        <h1 className="text-2xl font-semibold"> Home Page</h1>
      </div>
    </div>
  );
};

export default Dashboard;

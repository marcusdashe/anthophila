import React, { useState } from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";

const Dashboard = () => {
  const [open, setOpen] = useState(true);
  return (
    <div className="flex">
      <div
        className={`bg-purple-900 h-screen p-5 pt-8 ${
          open ? "w-72" : "w-19"
        } relative`}
      >
        <ArrowBackIcon
          onClick={() => setOpen(!open)}
          className="bg-white text-purple-900 text-3xl rounded-full absolute -right-3 top-9 cursor-pointer border border-purple-800"
        />
      </div>

      <div className="p-7">
        <h1 className="text-2xl font-semibold"> Home Page</h1>
      </div>
    </div>
  );
};

export default Dashboard;

import React from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";

const Dashboard = () => {
  return (
    <div className="flex">
      <div className="bg-purple-900 h-screen p-5 pt-8 w-70 text-white">
        <ArrowBackIcon />
      </div>

      <div className="p-7">
        <h1 className="text-2xl font-semibold"> Home Page</h1>
      </div>
    </div>
  );
};

export default Dashboard;

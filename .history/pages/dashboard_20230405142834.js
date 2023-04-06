import React from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";

const Dashboard = () => {
  return (
    <div className="flex">
      <div className="bg-purple-900 h-screen p-5 pt-8 w-70">
        <ArrowBackIcon className="bg-white text-purple-900 text-3xl rounded-full" />
      </div>

      <div className="p-7">
        <h1 className="text-2xl font-semibold"> Home Page</h1>
      </div>
    </div>
  );
};

export default Dashboard;

import React from 'react'

const Signup = () => {
  return (
    <div className="flex flex-col items-center justify-center h-screen bg-gray-100">
    <div className="bg-white p-10 rounded-lg shadow-lg">
      <h1 className="text-2xl font-medium mb-4">Create an account</h1>
      <form>
        <div className="mb-4">
          <label htmlFor="name" className="block text-gray-700 font-medium mb-2">Name</label>
          <input type="text" id="name" name="name" className="border-gray-400 border-2 rounded-lg py-2 px-3 w-full" />
        </div>
        <div className="mb-4">
          <label htmlFor="email" className="block text-gray-700 font-medium mb-2">Email</label>
          <input type="email" id="email" name="email" className="border-gray-400 border-2 rounded-lg py-2 px-3 w-full" />
        </div>
        <div className="mb-4">
          <label htmlFor="password" className="block text-gray-700 font-medium mb-2">Password</label>
          <input type="password" id="password" name="password" className="border-gray-400 border-2 rounded-lg py-2 px-3 w-full" />
        </div>
        <button type="submit" className="bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg">Sign up</button>
      </form>
    </div>
  </div>
);
}



export default Signup
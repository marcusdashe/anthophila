import React from "react";
import LZMA from "lzma-js";

const WillUpload = (props) => {
  const [files, setFiles] = React.useState([]);

  const handleFileChange = (e) => {
    const fileReader = new FileReader();
    fileReader.readAsDataURL(file);
    fileReader.onload = () => {
      // Convert the base64 encoded string to a Uint8Array
      const uint8Array = Uint8Array.from(atob(fileReader.result), (c) =>
        c.charCodeAt(0)
      );
      // Compress the Uint8Array using LZMA-JS
      LZMA.compress(uint8Array, 9, (result, error) => {
        if (error) {
          // Handle error
        } else {
          // The compressed data is a Uint8Array, so you need to convert it to a base64 encoded string
          const compressedBase64String = btoa(String.fromCharCode(...result));
          console.log(compressedBase64String); // Outputs the compressed base64 encoded string
        }
      });
    };
    fileReader.onerror = (error) => {
      console.log(error);
    };
  };

  return (
    <>
      <h1>Upload file</h1>

      <input
        type="file"
        onChange={(e) => {
          e.preventDefault();
          handleFileChange(e.target.files);
        }}
      />
    </>
  );
};

export default WillUpload;

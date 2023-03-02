import React from 'react'
import { useRouter } from 'next/router'
import Web3 from 'web3'
import KeyboardBackspaceIcon from '@mui/icons-material/KeyboardBackspace'
import Link from 'next/link'



const Signin = () => {
    const [ error, setError ] = useState("")
    const [web3, setWeb3] = useState(null)

    const router = useRouter()
    const signingInAs = router.query.user
  return (
    <div>You have succesfully sign in as {signinAs.user}</div>
  )
}

export default Signin
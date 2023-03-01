import React from 'react'
import { useRouter } from 'next/router'

const Signin = () => {
    const router = useRouter()
    const signinAs = router.query
  return (
    <div>You have succesfully sign in as {signinAs.testator}</div>
  )
}

export default Signin
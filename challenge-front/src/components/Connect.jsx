import React from 'react'
import './Connect.css'

export const Connect = ({ accounts, setAccounts }) => {
  
  const isConnected = Boolean(accounts[0])

  const connectAccount = async () =>{
    if(window.ethereum){
      const account = await window.ethereum.request({
        method: "eth_requestAccounts", 
      })
      setAccounts(account)
      console.log(account);
    }
  }

  
  return (
    <div className='connect-div'>
      {isConnected ? (
        <p className='p-connect'>Connected</p>
      ) : (
        <button className='connect' onClick={connectAccount}>Connect</button>
      )}
    </div>
  )
}

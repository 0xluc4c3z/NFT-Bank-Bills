import React from 'react'
import './Main.css'

export const Main = ({ accounts }) => {

  const isConnected = Boolean(accounts[0])

  return (
    <div className='box-div'>
      <main className='box'>
        {isConnected ? (
          <p className='address'>{accounts}</p>
        ) : (<p className='address'>address</p>)}
        <header className='header'>
          <button>Mint</button>
          <input type="text" name="text" className="input" placeholder="Number" />
          <button>Convert</button>
        </header>
        <input type="text" className='input input-2' readOnly/>
      </main>
    </div>
  )
}

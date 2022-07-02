import { useState } from 'react'
import './App.css'
import { Connect } from './components/Connect'
import { Main } from './components/Main'

function App() {

  const[accounts, setAccounts] = useState([])

  return (
    <div className="App">
      <Connect accounts={accounts} setAccounts={setAccounts}/>
      <Main accounts={accounts} />
    </div>
  )
}

export default App

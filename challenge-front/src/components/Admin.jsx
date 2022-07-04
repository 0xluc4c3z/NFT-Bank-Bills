import React, { useRef } from 'react'
import './Admin.css'

export const Admin = ({ contract }) => {

  const inputRef1 = useRef();
  const inputRef2 = useRef();
  const inputRef3 = useRef();
  const inputRef4 = useRef();
  const inputRef5 = useRef();
  const inputRef6 = useRef();

  const handleChange = async () =>{
    let value1 = inputRef1.current.value
    let value2 = inputRef2.current.value
    let value3 = inputRef3.current.value
    let value4 = inputRef4.current.value
    let value5 = inputRef5.current.value
    let value6 = inputRef6.current.value
    await contract.ChangeStock(value1, value2, value3, value4, value5, value6)
  }

  return (
    <div>
      <p>Admin</p>
      <label>Peso1</label><input type="number" className='input input3' ref={inputRef1}/>
      <label>Peso5</label><input type="number" className='input input3' ref={inputRef2}/>
      <label>Peso10</label><input type="number" className='input input3' ref={inputRef3}/>
      <label>Peso20</label><input type="number" className='input input3' ref={inputRef4}/>
      <br />
      <label>Peso50</label><input type="number" className='input input3' ref={inputRef5}/>
      <label>Peso100</label><input type="number" className='input input3' ref={inputRef6}/>
      <button onClick={handleChange}>Change Stock</button>
    </div>
  )
}

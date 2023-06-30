import React, { useEffect, useState, useRef } from 'react';
import './Main.css';
import { ethers } from "ethers";
import ChallengeABI from '../web3/ChallengeABI.json';
import { Admin } from './Admin';
// import * as dotenv from "dotenv";

// dotenv.config();

const ChallengeAddress = "0xdEfe5DBFe45a3C2e8878C211b404CDf2AC25B256"

export const Main = ({ accounts }) => {

  const isConnected = Boolean(accounts[0])
  const[contract, setContract] = useState()
  const[value, setValue] = useState()

  const[peso1, setPeso1] = useState()
  const[peso5, setPeso5] = useState()
  const[peso10, setPeso10] = useState()
  const[peso20, setPeso20] = useState()
  const[peso50, setPeso50] = useState()
  const[peso100, setPeso100] = useState()

  const isAdmin = Boolean(accounts[0] === ("0x31b8828625cAAB7548b563f256eC297313C28a00").toLowerCase())

  const inputRef = useRef();

  useEffect(() =>{
    let wallet
    if(window.ethereum){
      const provider = new ethers.providers.JsonRpcProvider("https://eth-goerli.g.alchemy.com/v2/Lnd36YL2Kb6uFv-Twl2_o4PrPRQMqDg4");
      wallet = accounts[0]
      console.log(wallet);
      const signer = provider.getSigner(wallet);
      const contract = new ethers.Contract(
        ChallengeAddress,
        ChallengeABI.abi,
        signer
      )
      setContract(contract)  
      handleStock()
    }
  }, [isConnected])


  const handleConvert = async () =>{
    if (isConnected === false) return alert('YOU NEED TO CONNECT')
    handleStock()
    let input = inputRef.current.value
    if (Number(input) === 0 || Number(input) === null || Number(input) === undefined) return alert('ENTER A VALID NUMBER FOR CONVERT')
    let value = await contract.ConvertDenom(Number(input))
    let arr = convert(value)

    setValue(arr)
  }
  
  const convert = (value) =>{
    let arr = []
    let claves = Object.keys(value)
    console.log(claves);
    for(let i = 0; i < claves.length; i++){
      let clave = claves[i]
      if(clave === "peso1" || clave === "peso5" || clave === "peso10" || clave === "peso20" || clave === "peso50" || clave === "peso100"){
        let close = Number(value[clave])
        if(close != 0){
          for(let x = 0; x < close; x++){
            if(clave === "peso1"){
              arr.push(1)
            }
            if(clave === "peso5"){
              arr.push(5)
            }
            if(clave === "peso10"){
              arr.push(10)
            }
            if(clave === "peso20"){
              arr.push(20)
            }
            if(clave === "peso50"){
              arr.push(50)
            }
            if(clave === "peso100"){
              arr.push(100)
            }
          }
        }
      }     
    }
    let reversed = arr.reverse()
    return reversed;
  }

  const handleStock = async () =>{
    let value = await contract.BalanceStock()
    let values = Object.values(value)
    setPeso1(Number(values[0]))
    setPeso5(Number(values[1]))
    setPeso10(Number(values[2]))
    setPeso20(Number(values[3]))
    setPeso50(Number(values[4]))
    setPeso100(Number(values[5]))
  }


  const handleMint = async () =>{
    if (isConnected === false) return alert('YOU NEED TO CONNECT')
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const signer = provider.getSigner();
    const contract = new ethers.Contract(
      ChallengeAddress,
      ChallengeABI.abi,
      signer
    )
    let input = inputRef.current.value
    if (Number(input) === 0 || Number(input) === null || Number(input) === undefined) return alert('ENTER A VALID NUMBER FOR MINT')
    await contract.Mint(Number(input))
  }

  return (
    <div className='box-con'>
      <div className='box-div'>
        <main className='box'>
          {isConnected ? (
            <p className='address'>{accounts}</p>
          ) : (<p className='address'>address</p>)}
          <header className='header'>
            <button onClick={handleMint}>Mint</button>
            <input type="number" name="text" className="input" placeholder="Number" ref={inputRef} />
            <button onClick={handleConvert}>Convert</button>
          </header>
          <input type="text" className='input input-2' readOnly value={value} />
          {isAdmin ? (
            <Admin contract={contract} />
          ) : (
            ""
          )}
        </main>
      </div>
      <div className='box-stock'>
        <label className='pesos'>Peso 1: {peso1}</label>
        <label className='pesos'>Peso 5: {peso5}</label>
        <label className='pesos'>Peso 10: {peso10}</label>
        <label className='pesos'>Peso 20: {peso20}</label>
        <label className='pesos'>Peso 50: {peso50}</label>
        <label className='pesos'>Peso 100: {peso100}</label>
      </div>
    </div>
  )
}

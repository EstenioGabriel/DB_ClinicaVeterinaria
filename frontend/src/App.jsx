import { RelatorioAgendamento } from './features/relatorioAgendamento/RelatorioAgendamento'
import { ReciboValores } from './features/reciboValores/ReciboValores'
import { RelacaoMedicos } from './features/relacaoMedicos/RelacaoMedicos'
import './App.css'

function App() {
  return (
    <div className='container'>
      <header className='header'>
        <h1>PetReact</h1>
        <p>Painel Administrativo da clinica veterinaria</p>
      </header>

      <RelatorioAgendamento/>

      <ReciboValores/>

      <RelacaoMedicos/>
    </div>  
  )
}

export default App

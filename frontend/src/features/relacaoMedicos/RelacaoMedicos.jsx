import { useState, useEffect } from "react";
import { relacaoMedicos as buscarRelacao } from "./relacaoMedicosService";

export function RelacaoMedicos () {
    const [relacao, setRelacao] = useState([]);
    const [exibirRelacao, setExibirRelacao] = useState(false);

    useEffect(() => {
        buscarRelacao()
            .then((dados) => {
                setRelacao(dados);
            })
            .catch((erro) => {
                console.log("Erro ao carregar dados no componente". erro);
            });
    }, []);

    return(
        <>
            <div className="control-panel">
                <button
                    className={`btn-relatorio ${exibirRelacao ? 'ativo' : ''}`}
                    onClick={() => setExibirRelacao(!exibirRelacao)}
                >
                    {exibirRelacao ? '📊 Ocultar Valores' : '📊 Relação de medicos veterinarios'}
                </button>
            </div>

            {exibirRelacao && (
                <div className="relacao-medicos-veterinarios animar-entrada">
                    {relacao.length > 0 ? (
                        <div className="grid-cards">
                            {relacao.map((relacao, index) => (
                                <div className="card-header">
                                    <h3><strong>Data De Atendimento:</strong> {relacao.data_atendimento}</h3>
                                    <p><strong>Nome do Veterinario:</strong> {relacao.veterinario}</p>
                                    <p><strong>CRMV: </strong> {relacao.CRMV}</p>
                                    <p><strong>Data Do Atendimento: </strong> {relacao.data_atendimento}</p>
                                    <p><strong>Nome Do Pet: </strong> {relacao.nome_do_pet}</p>
                                    <p><strong>Procedimento: </strong> {relacao.procedimento}</p>
                                </div>
                            ))}
                        </div>
                    ): (
                        <p className="mensagem-vazia">Nenhuma consulta encontrada</p>
                    )}
                </div>
            )}
        </>
    )
}
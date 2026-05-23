import { useState, useEffect } from "react";
import { reciboValores as buscarRecibosMes } from "./reciboValoresService";

export function ReciboValores () {
    const [recibo, setRecibo] = useState([]);
    const [exibirRelatorioRecibos, setExibirRelatorioRecibos] = useState(false);

    useEffect(() => {
        buscarRecibosMes()
            .then((dados) => {
                setRecibo(dados);
            })
            .catch((erro) => {
                console.log("Erro ao carregar dados no componente", erro);
            });
    }, []);

    return(
        <div>
            <div className="control-panel">
                <button
                    className={`btn-relatorio ${exibirRelatorioRecibos ? 'ativo' : ''}`}
                    onClick={() => setExibirRelatorioRecibos(!exibirRelatorioRecibos)}
                >
                    {exibirRelatorioRecibos ? '📊 Ocultar Valores' : '📊 Relação de valores recebidos'}
                </button>
            </div>

            {exibirRelatorioRecibos && (
                <div className="relatorio-recibos animar-entrada">
                    {recibo.length > 0 ? (
                        <div className="grid-cards">
                            {recibo.map((recibo, index) => (
                                <div className="card-agendamento" key={index}>
                                    <h3><strong/>Data: {recibo.data_da_entrada}</h3>
                                    <p><strong>Nome Do Tutor:</strong> {recibo.nome_do_tutor}</p>
                                    <p><strong>Nome Do Pet:</strong> {recibo.nome_do_pet}</p>
                                    <p><strong>Descricao:</strong> {recibo.descricao_do_item}</p>
                                    <p><strong>Servico:</strong> {recibo.categoria_do_servico}</p>
                                    <p><strong>Forma De Pagamento:</strong> {recibo.meio_de_pagamento}</p>
                                    <p><strong>Valor Recebido:</strong> {recibo.valor_recebido}</p>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p className="mensagem-vazia">Nenhuma consulta entrada...</p>
                    )}
                </div>
            )}

        </div>
    )
}
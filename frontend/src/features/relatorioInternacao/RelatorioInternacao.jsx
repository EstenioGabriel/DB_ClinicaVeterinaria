import { useState, useEffect } from "react";
import { relatarioInternacoes as buscarRelatorio } from "./relatorioInternacaoService";

export function RelatorioInternacao () {
    const [relatorioInternacao, setRelatorioInternacao] = useState([]);
    const [exibirRelacao, setExibirRelacao] = useState(false);

    useEffect(() => {
        buscarRelatorio()
            .then((dados) => {
                setRelatorioInternacao(dados);
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
                    {exibirRelacao ? '📊 Ocultar Relatorios' : '📊 Relatorios de Internacao'}
                </button>
            </div>

            {exibirRelacao && (
                <div className="relatorioInternacao animar-entrada">
                    {relatorioInternacao.length > 0 ? (
                        <div className="grid-cards">
                            {relatorioInternacao.map((relatorioInternacao, index) => (
                                <div className="card-agendamento" key={index}>
                                    <h3><strong>Nome Do Pet: </strong>{relatorioInternacao.pet}</h3>
                                    <p><strong>Tutor: </strong>{relatorioInternacao.tutor}</p>
                                    <p><strong>Leito: </strong>{relatorioInternacao.leito}</p>
                                    <p><strong>Data De Entrada: </strong>{relatorioInternacao.data_entrada}</p>
                                    <p><strong>Previsao De Alta: </strong>{relatorioInternacao.previsao_alta}</p>
                                    <p><strong>Valor Total R$: </strong>{relatorioInternacao.valor_total}</p>
                                    <p><strong>Valor Pago R$: </strong>{relatorioInternacao.valor_pago}</p>
                                    <p><strong>Valor Pendente R$: </strong>{relatorioInternacao.valor_pendente}</p>
                                    <p><strong>Status Pagamento:</strong>{relatorioInternacao.status_pagamento}</p>
                                </div>
                            ))}
                        </div>
                    ): (
                        <p className="mensagem-vazia">Nenhuma consulta encontrada</p>
                    )}
                </div>
            )}
        </>
    );
}
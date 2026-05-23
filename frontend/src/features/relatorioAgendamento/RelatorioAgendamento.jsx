import { useState, useEffect } from "react";
import { relatorioAgendamento as buscarAgendamentoService } from "./relatorioAgendamentoService";

export function RelatorioAgendamento() {
    const [agendamentos, setAgendamentos] = useState([]);
    const [exibirRelatorio, setExibirRelatorio] = useState(false);

    useEffect(() => {
        buscarAgendamentoService()
            .then((dados) => {
                setAgendamentos(dados);
            })
            .catch((erro) => {
                console.log("Erro ao carregar dados no componente". erro);
            });
    }, []);

    const formatarData = (dataString) => {
        if (!dataString) return '';
        const data = new Date(dataString);
        return new Date(dataString).toLocaleDateString('pt-BR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute:'2-digit'
        });
    };

    return (
        <div>
            <div className="control-panel">
                <button
                    className={`btn-relatorio ${exibirRelatorio ? 'ativo' : ''}`}
                    onClick={() => setExibirRelatorio(!exibirRelatorio)}
                >
                    {exibirRelatorio ? '📊 Ocultar Relatório' : '📊 Relatório de agendamentos'}
                </button>
            </div>

            {exibirRelatorio && (
                <div className='relatorio-agendamentos animar-entrada'>
                    {agendamentos.length > 0 ? (
                        <div className='grid-cards'>
                            {agendamentos.map((agendamento, index) => (
                                <div className='card-agendamento' key={agendamento.id_agendamento || index}>
                                    <div className='card-header'>
                                        <h3>🐾 {agendamento.nome_do_pet}</h3>
                                        <span className='tag-data'>📅 : {formatarData(agendamento.data_da_consulta)}</span>
                                    </div>
                                    <div className='card-body'>
                                        <p><strong>👤 Tutor:</strong> {agendamento.nome_do_tutor}</p>
                                        <p><strong>📞 Contato:</strong> {agendamento.telefone_do_tutor}</p>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p className='mensagem-vazia'>Nenhuma consulta encontrada...</p>
                    )}
                    </div>
                )}
                </div>
    )
}
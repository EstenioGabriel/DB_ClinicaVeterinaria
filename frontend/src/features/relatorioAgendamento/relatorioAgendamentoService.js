export const relatorioAgendamento = async () => {
    try {
        const resposta = await fetch ('/api/relatorioAgendamento'); 
        if(!resposta.ok) throw new Error('Erro na requisicao');
        return await resposta.json();
    }catch (erro) {
        console.log("Erro no servico de agendamento", erro);
        throw erro;
    }
};
export const relatarioInternacoes = async () => {
    try {
        const resposta = await fetch ('/api/relatorioInternacoes');
        if(!resposta.ok) throw new Error('Erro na requisicao');
        return await resposta.json();
    }catch (erro) {
        console.log("Erro no servico de relatorios de internacoes", erro);
        throw erro;
    }
};
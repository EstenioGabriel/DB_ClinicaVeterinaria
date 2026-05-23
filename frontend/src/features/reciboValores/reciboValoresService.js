export const reciboValores = async () => {
    try {
        const resposta = await fetch ('/api/valoresRecebidos');
        if(!resposta.ok) throw new Error ('Erro na requisicao');
        return await resposta.json();
    }catch(erro){
        console.log("Erro no servico de recibo de valores");
        throw erro;
    }
};
export const relacaoMedicos = async () => {
    try {
        const resposta = await fetch ('/api/relacaoVeterinarios');
        if(!resposta.ok) throw new Error ('Erro na requisicao');
        return await resposta.json();
    }catch(erro){
        console.log("Erro no servico de relacao de medicos veterinarios");
        throw erro;
    }
}
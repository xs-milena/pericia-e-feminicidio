var database = require("../database/config")

function autenticar(codigo_ativacao, email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", codigo_ativacao, email, senha)
    var instrucaoSql = `
        SELECT f.id_funcionario, f.nome, f.email, inst.codigo_ativacao as codigo_ativacao, inst.id_instituto 
        FROM funcionario f
        join instituto_criminal inst on inst.id_instituto = f.fk_instituto
        WHERE inst.codigo_ativacao = '${codigo_ativacao}' AND f.email = '${email}' AND f.senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, cpf, telefone, email, senha, cargo, fk_instituto) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, cpf, senha, fk_instituto);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO funcionario (nome, cpf, telefone, email, senha, cargo, fk_instituto) VALUES ('${nome}', '${cpf}', '${telefone}', '${email}', '${senha}', '${cargo}', '${fk_instituto}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};
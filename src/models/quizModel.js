var database = require("../database/config");

function quiz_reflexao(id_tentativa, fk_usuario, pergunta, alternativa) {
    console.log("ACESSEI O QUIZ MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", id_tentativa, fk_usuario, pergunta, alternativa);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO quiz_reflexao (id_tentativa, fk_usuario, pergunta, alternativa) VALUES ('${id_tentativa}', '${fk_usuario}', '${pergunta}', '${alternativa}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function quiz_pericia(fk_usuario, acertos, erros, total_questoes) {
    console.log("ACESSEI O QUIZ MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", fk_usuario, acertos, erros, total_questoes);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO quiz_pericia (fk_usuario, acertos, erros, total_questoes) VALUES ('${fk_usuario}', '${acertos}', '${erros}', '${total_questoes}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    quiz_reflexao,
    quiz_pericia,
};
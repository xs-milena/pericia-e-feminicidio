var database = require("../database/config");

function buscarPorId(id_instituto) {
  var instrucaoSql = `SELECT * FROM instituto_criminal WHERE id_instituto = '${id_instituto}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT id_instituto, cnpj, nome, email, codigo_ativacao FROM instituto_criminal`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM instituto_criminal WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(nome, cnpj) {
  var instrucaoSql = `INSERT INTO instituto_criminal (nome, cnpj) VALUES ('${nome}', '${cnpj}')`;

  return database.executar(instrucaoSql);
}

module.exports = {buscarPorCnpj, buscarPorId, cadastrar, listar };

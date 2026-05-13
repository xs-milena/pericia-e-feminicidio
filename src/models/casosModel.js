var database = require("../database/config");

function buscarCasosPorInstituto(id_instituto) {

  var instrucaoSql = `SELECT * 
  FROM caso_feminicidio c
  join instituto_criminal on id_instituto = c.fk_instituto
  WHERE fk_instituto = ${id_instituto}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(id_instituto) {
  
  var instrucaoSql = `INSERT INTO (fk_instituto) caso_feminicidio VALUES (${id_instituto})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarCasosPorInstituto,
  cadastrar
}

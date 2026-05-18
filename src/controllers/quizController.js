var quizModel = require("../models/quizModel");


function quiz_reflexao(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var id_tentativa = req.body.id_tentativa;
    var fk_usuario = req.body.fk_usuario;
    var pergunta = req.body.pergunta;
    var alternativa = req.body.alternativa;

    // Faça as validações dos valores

      if (id_tentativa == undefined) {
        res.status(400).send("Seu tentativa está undefined!");
      } else if (fk_usuario == undefined) {
        res.status(400).send("Seu usuário está indefinida!");
      } else if (pergunta == undefined) {
        res.status(400).send("Sua pergunta está indefinida!");
     } else if (alternativa == undefined) {
        res.status(400).send("Sua alternativa está indefinida!");
      } else {

        // Passe os valores como parâmetro e vá para o arquivo quizModel.js
        quizModel
        .quiz_reflexao(id_tentativa, fk_usuario, pergunta, alternativa)
        .then(function (resultado) {
        res.json(resultado);
        })
          .catch(function (erro) {
            console.log(erro);
            console.log(
              "\nHouve erro ao salvar respostas do quiz  no Banco de Dados",
              erro.sqlMessage,
            );
            res.status(500).json(erro.sqlMessage);
          });
      }
    }

function quiz_pericia(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var fk_usuario = req.body.fk_usuario;
    var acertos = req.body.acertos;
    var erros = req.body.erros;
    var total_questoes = req.body.total_questoes;

    // Faça as validações dos valores

      if (fk_usuario == undefined) {
        res.status(400).send("Seu usuário está indefinida!");
      } else if (acertos == undefined) {
        res.status(400).send("Seus acertos estão indefinidos!");
      } else if (erros == undefined) {
        res.status(400).send("Seus erros estão indefinidos!");
     } else if (total_questoes == undefined) {
        res.status(400).send("O total de suas questões estão indefinidas!");
      } else {

        // Passe os valores como parâmetro e vá para o arquivo quizModel.js
        quizModel
        .quiz_pericia(fk_usuario, acertos, erros, total_questoes)
        .then(function (resultado) {
        res.json(resultado);
        })
          .catch(function (erro) {
            console.log(erro);
            console.log(
              "\nHouve ao  salvar respostas do quiz ",
              erro.sqlMessage,
            );
            res.status(500).json(erro.sqlMessage);
          });
      }
    }


    

module.exports = {
  quiz_reflexao,
  quiz_pericia,
};

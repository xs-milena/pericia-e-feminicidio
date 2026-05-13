var institutoCriminalModel = require("../models/institutoCriminalModel");

function buscarPorCnpj(req, res) {
  var cnpj = req.query.cnpj;

  institutoCriminalModel.buscarPorCnpj(cnpj).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listar(req, res) {
  institutoCriminalModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id_instituto = req.params.id_instituto;

  institutoCriminalModel.buscarPorId(id_instituto).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrar(req, res) {
  var cnpj = req.body.cnpj;
  var nome = req.body.nome;

  institutoCriminalModel.buscarPorCnpj(cnpj).then((resultado) => {
    if (resultado.length > 0) {
      res
        .status(401)
        .json({ mensagem: `O Instituto Criminal com o cnpj ${cnpj} já existe` });
    } else {
      institutoCriminalModel.cadastrar(nome, cnpj).then((resultado) => {
        res.status(201).json(resultado);
      });
    }
  });
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
};

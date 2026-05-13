var express = require("express");
var router = express.Router();

var institutoCriminalController = require("../controllers/institutoCriminalController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    institutoCriminalController.cadastrar(req, res);
})

router.get("/buscar", function (req, res) {
    institutoCriminalController.buscarPorCnpj(req, res);
});

router.get("/buscar/:id_instituto", function (req, res) {
  institutoCriminalController.buscarPorId(req, res);
});

router.get("/listar", function (req, res) {
  institutoCriminalController.listar(req, res);
});

module.exports = router;
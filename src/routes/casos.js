var express = require("express");
var router = express.Router();

var casosController = require("../controllers/casosController");

router.get("/:id_instituto", function (req, res) {
  casosController.buscarCasosPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  casosController.cadastrar(req, res);
})

module.exports = router;
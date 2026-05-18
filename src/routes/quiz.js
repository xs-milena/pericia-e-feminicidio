var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/quiz_reflexao", function (req, res) {
    quizController.quiz_reflexao(req, res);
})

router.post("/quiz_pericia", function (req, res) {
    quizController.quiz_pericia(req, res);
});

module.exports = router;
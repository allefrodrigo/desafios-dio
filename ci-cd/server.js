// Importar o módulo Express
const express = require('express');

// Inicializar o aplicativo Express
const app = express();

// Definir uma rota GET para a raiz ('/')
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Iniciar o servidor na porta 3000
app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});

/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

depth = -y;


//Recuperando o poise
poise = min(poise_max, poise + poise_max * 0.001);

if(gerado) exit;

// Rodando os estados

roda_estado();
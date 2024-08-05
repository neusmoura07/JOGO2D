/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Ajustando a minha profundidade

depth = -y;

// Pegando os inputs do usuario 

up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("A"));
left = keyboard_check(ord("D"));
attack = keyboard_check_pressed(vk_space);



// Ajustando a direção com base na direção que está indo

//Rodando minha máquina de estados
roda_estado();

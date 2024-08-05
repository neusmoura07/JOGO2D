/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

meu_dano = noone;
dano_poise = 3;

//Iniciando o meu primeiro estado
estado_idle = new estado();

//Iniciando estado walk
estado_walk = new estado();

//Iniciando estado ataque
estado_attack = new estado();
#region estado_idle
// Meu estado idle precisa de um inicia
estado_idle.inicia = function()
{
	//Definindo a sprite atual com base na direção que estou olhando
	dir = floor(dir) % 4; // Garantir que dir seja um valor inteiro entre 0 e 3
	var _sprite = define_sprite(dir, spr_player_idle_side, spr_player_idle_front, spr_player_idle_back);
	
	//Ajustando a sprite
	sprite_index = _sprite;
	
	//Garantindo que a animação começa no primeiro frame
	image_index = 0;
}

estado_idle.roda = function()
{
		//Achando a condição para eu sair desse estado
		
		//Se eu estiver em movimento, irei para o estado de walk
		if (up xor down or left xor right) 
		{
			troca_estado(estado_walk);
		}
		
		// Condição para ir para o estado de ataque
		if (attack) 
		{
			troca_estado(estado_attack);
		}
}
#endregion

#region estado_walk
estado_walk.inicia = function()
{
	dir = (point_direction(0, 0, right - left, down - up) / 90);
	dir = floor(dir) % 4; // Garantir que dir seja um valor inteiro entre 0 e 3
	
	//Definindo a sprite
	sprite_index = define_sprite(dir, spr_player_walk_side, spr_player_walk_front, spr_player_walk_back);
	
	//Começando a animação do começo
	image_index = 0;
	
}

estado_walk.roda = function() 
{
	velv = (down - up) * vel;
	velh = (left - right) * vel;
	dir = (point_direction(0, 0, velh, velv) / 90);
	dir = floor(dir) % 4; // Garantir que dir seja um valor inteiro entre 0 e 3
	
	//Ajustando o lado que ele olha
	if (velh != 0)
	{
		image_xscale = sign(-velh);
	}
	
	if(velh == 0 && velv == 0)
	{
		troca_estado(estado_idle);
	}
	
	//Indo para o estado de ataque
	if (attack)
	{
		troca_estado(estado_attack);
	}
}
#endregion

#region estado_attack

estado_attack.inicia = function() 
{
	//Definindo a sprite dele
	sprite_index = define_sprite(dir, spr_player_attack_side, spr_player_attack_front, spr_player_attack_back);
	
	image_index = 0;
	
	velh = 0;
	velv = 0;
	
	//Criando o dano
	var _x = x + lengthdir_x(16, dir * 90);
	var _y = y + lengthdir_y(16, dir * 90);
	
	meu_dano = instance_create_depth(_x, _y, depth, obj_dano_player);
	
	//Passando o meu poise para o meu dano
	meu_dano.dano_poise = dano_poise;
}

// Configurando o estado de ataque
estado_attack.roda = function()
{
	
	//Saindo do ataque quando ele acabar
	if(image_index >= image_number-0.2)
	{
		
		//Indo para o estado parado
		troca_estado(estado_idle);
	}
	
}

estado_attack.finaliza = function()
{
	//Encerro o dano
	instance_destroy(meu_dano);
}

#endregion
// INICIAR VARIAVEIS
#region iniciando variáveis
// Controles
up = noone;
down = noone;
left = noone;
right = noone;
attack = noone;

//Variáveis em movimento
velh = 0;
velv= 0;

// Velocidade do Jogador
vel = 2;

//Controlando a direção que o player está olhando
dir = 0;
#endregion
//Iniciando minha máquina de estados
inicia_estado(estado_idle);
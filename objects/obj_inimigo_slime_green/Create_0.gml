/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

range = 30;
dir = 0;
//Criando uma estrutura com as sprites dele
sprite =
{
	attack: spr_slime_green_attack,
	death: spr_slime_green_death,
	hurt: spr_slime_green_hurt,
	idle: spr_slime_green_idle,
	walk: spr_slime_green_walk
};

//Criando o estado de attack
estado_attack.inicia = function()
{
	sprite_index = sprite.attack;
	image_index = 0;
	
	dir = point_direction(x, y, alvo.x, alvo.y);
}

estado_attack.roda = function ()
{
	if (image_index >= 7) 
	{
		var _dir = point_direction(x, y, alvo.x, alvo.y);
		//Se movendo na direcao do player
		var _x = lengthdir_x(1.5, dir);
		var _y = lengthdir_y(1.5, dir);
		
		//Me movendo SE eu não estou colidindo com a parede
		if(!place_meeting(x + _x, y + _y, obj_colisor))
		{
			x += _x;
			y += _y;
		}
		
			//Saindo do estado de ataque
		if(image_index >= image_number - .5)
		{
			troca_estado(estado_idle);
		}
	}
}



inicia_estado(estado_idle);
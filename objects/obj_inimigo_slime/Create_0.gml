/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Criando um timer para mudar de estado
tempo_estado = game_get_speed(gamespeed_fps) * 15;
timer_estado = tempo_estado;

range = 10;
//Criando uma estrutura com as sprites dele
sprite =
{
	attack: spr_slide_blue_attack,
	death: spr_slide_blue_death,
	hurt: spr_slide_blue_hurt,
	idle: spr_slide_blue_idle,
	walk: spr_slide_blue_walk
};

destinox = 0;
destinoy = 0;
alvo = noone;

// Inherit the parent event
event_inherited();

estado_hunt = new estado();

// Tudo o que vier depois desse código será sobrescrito
#region estado_idle

estado_idle.inicia = function()
{
	//Definir a sprite que ele vai usar
	sprite_index = sprite.idle;
	//Iniciar a animação do começo
	image_index = 0;
	
	image_blend = c_white;
	
	// Resetando o time do estado
	timer_estado = tempo_estado;
}

estado_idle.roda = function()
{
	//Diminuindo o time do estado
	timer_estado --;
	
	var _tempo = irandom(timer_estado);
	
	if(_tempo <= 5)
	{
		var _estado_novo = choose(estado_idle, estado_walk, estado_walk);
		troca_estado(_estado_novo);
	}
}

#endregion

#region estado_walk

estado_walk.inicia = function()
{
	sprite_index = sprite.walk;
	image_index = 0;
	
	// Resetando o time do estado
	timer_estado = tempo_estado;
	
	//Escolhendo um local no mapa e indo até ele
	
	//Escolhendo aleatoriamente um local no mapa
	destinox = irandom(room_width);
	destinoy = irandom(room_height);
	
	//Definindo meu xscale com base no destino x
	xscale = sign(destinox - x);
	
	
	
}

estado_walk.roda = function()
{
	//Diminuindo o time do estado
	timer_estado --;
	
	var _tempo = irandom(timer_estado);
	
	if(_tempo <= 5)
	{
		var _estado_novo = choose(estado_idle, estado_walk);
		
		//troca_estado(_estado_novo);
	}
	
	//Indo até meu destino enquanto desvio dos colisores
	mp_potential_step_object(destinox, destinoy, 1, all);	
}


#endregion

#region estado_attack

estado_attack.inicia = function()
{
	sprite_index = sprite.attack;
	image_index = 0;
}

estado_attack.roda = function()
{
	
	
	//Saindo do estado de ataque
	if(image_index >= image_number - .5)
	{
		troca_estado(estado_idle);
	}
}

estado_attack.finaliza = function()
{
	alvo = noone;
}

#endregion

#region estado_hurt

estado_hurt.inicia = function()
{
	sprite_index = sprite.hurt;
	image_index = 0;

}

estado_hurt.roda = function()
{
	// Saindo do estado de dano
	//Se ainda tenho vida eu vou para o estado idle
	//Checando se a animação acabou
	if(image_index >= image_number - .5)
	{
		if( vida > 0)
		{
			troca_estado(estado_hunt);
		}
		else
		{
			troca_estado(estado_death);
		}
	}
	
}

//Depois que eu tomei o dano, eu zero o poise
estado_hurt.finaliza = function()
{
	if(poise < 1)
	{
		poise = poise_max;
	}
}

#endregion

#region estado_death

estado_death.inicia = function()
{
	sprite_index = sprite.death;
	image_index = 0;
	
	dead = true;
}

estado_death.roda = function()
{
	//Morrendo
	if(image_index >= image_number - .5)
	{
		instance_destroy();
	}
	
}

#endregion

#region estado_hunt

estado_hunt.inicia = function()
{
	sprite_index = sprite.walk;
	image_index = 0;
	
	
	if(instance_exists(obj_player))
	{
		alvo = obj_player;
	}
	
	cria_aviso();
}

estado_hunt.roda = function()
{
	//Se o alvo não existe mais, eu fico de boa
	if(!instance_exists(obj_player))
	{
		alvo = noone;
		troca_estado(estado_idle);
	}
	//Definindo o meu alvo como player
	//Seguindo o meu alvo
	mp_potential_step_object(alvo.x, alvo.y, 1, obj_colisor);
	
	//Atacando o player
	//Checando a distancia para o player
	var _dist = point_distance(x, y, alvo.x, alvo.y);
	
	if (_dist <= range)
	{
		troca_estado(estado_attack);
	}
	
	xscale = sign(alvo.x - x);
	
	//Avisando a galera que precisa de ajuda
	//Checando quantos de nós tem nesse level
	
	var _n = instance_number(object_index);
	//Passando por todos os objetos iguais a mim
	for (var i = 0; i < _n; i++)
	{
		//Checando se não estou olhando para mim mesmo
		var _slime = instance_find(object_index, i);
		
		if(_slime ==id)
		{
			//Não faço nada pq esse sou eu
		}
		else
		{
			//Tenho que checar se esse cara ainda não estar perseguindo o alvo
			if(_slime.alvo != alvo)
			{
				
				//Checando a distancia desses slimes
				var _dist = point_distance(x,y,_slime.x, _slime.y);
				if(_dist < 80)
				{
					//Falando para me ajudar
				with(_slime)
				{
					troca_estado(estado_hunt);
				}
				}
				
			}
		}
	}
	
	
	
}


#endregion



//Iniciando o estado COM as modificações
inicia_estado(estado_idle);



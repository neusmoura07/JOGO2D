/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Iniciando as variaveis comuns a todos os inimigos
xscale = 1;

velh = 0;
velv = 0;

// Iniciando todos os estados padroes de todos os inimigos

//Definindo o poise
poise = poise_max;
dead = false;

gerado = false;

//Cria aviso
cria_aviso = function()
{
	var _aviso = instance_create_depth(x, y,depth, obj_aviso);
	_aviso.pai = id; 
}

//Lidando com o dano
lida_dano = function(_dano = 1, _poise = 1)
{
	//Tirando a vida
	vida -= _dano;
	
	//Diminuindo o poise dele
	poise = max(poise - _poise, 0);
	
	//Só vou para o estado de hurt se o meu poiso for zerado
	
	if(poise <= 0 or estado_atual != estado_attack)
	{
		//Vou para o estado de hurt
		troca_estado(estado_hurt);
	}
	
	
}

estado_idle = new estado();
estado_walk = new estado();
estado_attack = new estado();
estado_hurt = new estado();
estado_death = new estado();


//Iniciando o estado idle por padrão
inicia_estado(estado_idle);
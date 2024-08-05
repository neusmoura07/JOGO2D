// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function estado() constructor
{
	
	//Iniciando Estado
	static inicia = function() {};
	//Rodando Estado
	static roda = function() {};
	//Finalizando Estado
	static finaliza = function () {};
}

//Funções para controlar máquina de estado

function inicia_estado(_estado)
{
	//Salvando o  estado passado em uma variável
	estado_atual = _estado
	
	//Iniciando o estado atual
	estado_atual.inicia();
}

//Roda o estado
function roda_estado()
{
	estado_atual.roda();
}

//Trocando de estado
function troca_estado(_estado)
{
	//Finalizando o estado atual
	estado_atual.finaliza();
	
	//Rodando o próximo estado
	estado_atual = _estado;
	
	//Iniciando o próximo estado
	estado_atual.inicia();
	
}

//Definindo a sprite 
function define_sprite(_dir = 0, _sprite_side, _sprite_front, _sprite_back)
{	
	var _sprite = _sprite_side;
	
	switch(_dir)
	{
		case 0: _sprite = _sprite_side;break;
		case 1: _sprite = _sprite_back;break;
		case 2: _sprite = _sprite_side;break;
		case 3: _sprite = _sprite_front;break;
		default: _sprite = _sprite_front; break; // Adicionar um caso padrão
	}
	
	return _sprite;
	
}

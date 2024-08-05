/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Ajustando a profundidade

depth = -bbox_bottom;

if(transparente) 
{
	//Ficando transparente quando o player passar por trás de mim
//Checando se o player existe

	if (instance_exists(obj_player))
	{
		//Checando se o player está mais alto do que eu
		if(obj_player.y < y)
		{
			//Checando se o player está maios ou menos atrás de mim
			if(point_in_rectangle(obj_player.x, obj_player.y, bbox_left - 10, bbox_top -25, bbox_right + 10, bbox_top))
			{
				//Ficando trasnparente
				image_alpha = lerp(image_alpha, .5, .05);
			}
			else
			{
				image_alpha = lerp(image_alpha, 1, .1);
			}
		}
	}	
}



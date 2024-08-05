/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Se eu não tenho pai eu me destruo
if(!pai) 
{
	instance_destroy();
}

if(!instance_exists(pai))
{
	instance_destroy();
}

//Ficando na posição do pai
x = pai.x;
y = pai.bbox_top;

image_alpha -= 0.02;


if(image_alpha <= 0)
{
	instance_destroy();
}
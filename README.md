
Objetivo: Criar um parser de um arquivo de log do jogo Quake

Autor: Gláuber Costa

Classes criadas:
	game
	main_parser_quake_log
	parser_quake_log
	parser_quake_log_errors_class
	player
	test_game
	test_main_parser_quake
	test_parser_quake_log
	test_player

Execução:
	- Para imprimir o relatório com os dados de todas as partidas do Log basta executar o arquivo:
		- main_parser_quake_log

		Ex. do formato de impressão da partida, no caso a partida número 20:

				game_20
				{       total_kills: 69
				    players:
				    {
				            Isgalamido,
				            Oootsimo,
				            Dono da Bola,
				            Assasinu Credi,
				            Zeh,
				            Mal
				    }
				    kills:
				    {
				            Isgalamido: 11
				            Oootsimo: 14
				            Dono da Bola: 7
				            Assasinu Credi: 11
				            Zeh: 14
				            Mal: 7
				    }
				    deaths_by_means:
				    {
				             MOD_SHOTGUN: 4
				             MOD_ROCKET_SPLASH: 32
				             MOD_ROCKET: 26
				             MOD_FALLING: 3
				             MOD_RAILGUN: 2
				             MOD_TRIGGER_HURT: 2
				    }

	- Para executar todos os testes basta executar o arquivo:
		- test_main_parser_quake 



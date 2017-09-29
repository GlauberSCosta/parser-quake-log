load "parser_quake_log.rb"


parser = ParserQuakeLog.new('games.log.original.txt')



labelQtdPartidas = "Quantidade de partidas"
puts "\n\n" + labelQtdPartidas +" no Log \n\n"
puts   parser.games.size
puts "\n\n---- FIM " + labelQtdPartidas + "---------"

puts parser.games


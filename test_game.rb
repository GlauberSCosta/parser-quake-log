class TestGame < Test::Unit::TestCase
	
	def test_initialize
		assert_raise(ParserQuakeLogException::MustBeInteger){Game.new('a')}
		assert_raise(ArgumentError){Game.new}
		assert_nothing_raised{Game.new 1}
	end

	def test_add_player
		player1 = Player.new "glauber_costa"
		player2 = Player.new "diluccia_andreza"
		match = Game.new 4

		assert_raise(ArgumentError){match.add_player nil}
		assert_nothing_raised{match.add_player player1}
		assert_nothing_raised{match.add_player player2}
	end


	def test_add_and_get_kills
		p1= Player.new "glauber_costa"
		p2= Player.new "diluccia_andreza"
		game = Game.new 1

		game.add_player p1
		game.add_player p2
		game.add_kill
		assert_equal(1, game.total_kills)
		game.add_kills("glauber_costa")
		game.add_deaths("diluccia_andreza")
		assert_equal(1, game.player("diluccia_andreza").deaths)
		assert_equal(1,game.player("glauber_costa").kills)
		game.subtract_kills("glauber_costa")
		assert_equal(0, game.player("glauber_costa").kills)
		game.update_kills_by_means("glauber_costa", "bereta")
		assert_equal({"bereta"=> 1}, game.player("glauber_costa").kills_by_means)
		game.update_deaths_by_means("glauber_costa", "mundo")
		assert_equal({"mundo"=>1}, game.player("glauber_costa").deaths_by_means)

		assert_raise(ParserQuakeLogException::MustBeString){game.update_kills_by_means("glauber_costa",1)}
		assert_raise(ParserQuakeLogException::MustBeString){game.update_deaths_by_means("glauber_costa",1)}
		assert_nothing_raised{game.subtract_kills("glauber_costa")}
		assert_nothing_raised{game.add_kills("glauber_costa")}
		
	end	
end
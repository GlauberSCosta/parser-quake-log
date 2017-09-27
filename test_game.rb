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
end
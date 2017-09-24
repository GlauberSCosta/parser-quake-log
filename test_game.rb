class TestGame < Test::Unit::TestCase
	
	def test_initialize
		assert_raise(ParserQuakeLogException::MustBeNumber){Game.new ('a')}
		assert_raise(ArgumentError){Game.new}
		assert_nothing_raised{Game.new 1}
	end
end
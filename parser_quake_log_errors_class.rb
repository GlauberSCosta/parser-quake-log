module ParserQuakeLogException
	class MustBeInteger < StandardError; end
	class MustBeString < StandardError; end
	class BlankString < StandardError; end
	class PlayerMustBeUnique < StandardError; end
	class PlayerNotExists < StandardError; end
end
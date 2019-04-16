module Ext
	class Extensions
		def initialize()
			
		end

		def handle(base, args)
			found = false

			found = handle_alias(base)

			return found
		end

		def handle_alias(base)
			if base == "x"
				puts "test"

			else
				return false
			end
		end

		def prompt()
			return Dir.current + " > "
		end
	end
	
end
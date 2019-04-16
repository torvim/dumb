module Ins
	class Builtins
		def initialize()
			
		end

		def handle(base, args)
			case base
				when "cd"
					Dir.cd(args[0])
				when "exit"
					exit()
				else
					return false
			end
		end
	end
end

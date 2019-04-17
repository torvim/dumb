module Ins
	class Builtins
		def initialize()
			@last_dir = Dir.current
		end

		def handle(base, args)
			case base
				when "cd"
					case args[0]
						when "~"
							home_dir = ENV["HOME"]
							@last_dir = Dir.current
							Dir.cd(home_dir)
						when "-"
							old_last_dir = @last_dir
							Dir.cd(@last_dir)
							@last_dir = old_last_dir
						else
							@last_dir = Dir.current
							Dir.cd(args[0])
					end

				when "exit"
					exit()
				else
					return false
			end
		end
	end
end

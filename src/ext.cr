require "./scripts/*"

module Ext
	class Extensions

		def initialize()
			
		end

		def colours()
			return {
				"base": :blue,
				"args": :white
			}
		end

		def user_scripts(base, args)
			if base == "ily"
				puts "i love you too"
			else
				return false
			end
		end

		def handle_alias(base)
			aliases = [["", ""]]

			aliases.each{ |alias_i| return alias_i[1] if base == alias_i[0]}
			return ""
		end

		def prompt()
			dir = Dir.current
			if ENV["HOME"] == dir
				return "~ > "
			else
				dir_last = dir.split("/").last
				return (dir_last + " ").colorize(:green).to_s
			end
		end
	end
end

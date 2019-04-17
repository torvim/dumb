module Ext
	class Extensions
		def initialize()
			
		end

		def user_scripts(base, args)
			return false
		end

		def colours(base, args, output)
			return output.colorize(:yellow).to_s
		end

		def handle_alias(base)
			aliases = [
				["rm", "trash"]
			]

			aliases.each{ |alias_i| return alias_i[1] if base == alias_i[0]}
			return ""
		end

		def prompt()
			dir = Dir.current
			if ENV["HOME"] == dir
				return "~ > "
			else
				dir_last = dir.split("/").last
				return dir_last + " > "
			end
		end
	end
end
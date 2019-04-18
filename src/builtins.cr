module Ins
	class Builtins
		def initialize()
			@last_dir = Dir.current
		end

		def prompt(fancy, extensions)
			fancy.display.add do |ctx, line, yielder|
				colour_config = extensions.colours()

				#base colours
				line = line.gsub(/^[^\s]+/, &.colorize(colour_config["base"]))
				#args colours
				line = line.gsub(/\B\-\w+/, &.colorize(colour_config["args"])) 
				

				# Then we call the next middleware with the modified line
				yielder.call ctx, line
			end

			fancy.autocomplete.add do |ctx, range, word, yielder|
				completions = yielder.call(ctx, range, word)

				Dir.glob("*" + word + "*").each { |file|
					completions << Fancyline::Completion.new(range, file)
				}

				completions
			end

			return fancy
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
							begin
								@last_dir = Dir.current
								Dir.cd(args[0])
							rescue
								puts "[#{args[0]}]: Directory not found"
							end
					end

				when "exit"
					exit()
				else
					return false
			end
		end
	end
end

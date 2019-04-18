require "fancyline"
require "./builtins.cr"
require "./ext.cr"

def run(base, args)
	#fork process and transorm into base and arguments
	process = Process.fork {
		begin
			Process.exec base, args
		rescue
			puts "[#{base}]: Command not found"
		end
	}
	#wait for process to end
	process.wait()
end	

def main()
	builtins = Ins::Builtins.new
	extensions = Ext::Extensions.new

	fancy = Fancyline.new

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

	while input = fancy.readline(extensions.prompt()) # Ask the user for input
		next if input.nil? || input.empty?
		input = input.split(" ")

		#split input into base and arguments
		base = input.shift
		args = input

		aliased = extensions.handle_alias(base).split(" ")
		if aliased != [""]
			alias_base = aliased.shift
			alias_args = aliased
			run alias_base, alias_args
			
		elsif extensions.user_scripts(base, args) != false
		elsif builtins.handle(base, args) != false
		else
			run base, args
		end
	end
end

main()
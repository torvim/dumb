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
	fancy = Fancyline.new

	fancy.autocomplete.add do |ctx, range, word, yielder|
		completions = yielder.call(ctx, range, word)

		Dir.new("./").each { |file|
			if file.starts_with?(word)
				completions << Fancyline::Completion.new(range, file)
			end
		}

		 completions
	end

	builtins = Ins::Builtins.new
	extensions = Ext::Extensions.new

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
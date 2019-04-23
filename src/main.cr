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

def handle(base, args, extensions, builtins)
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

def main()
	builtins = Ins::Builtins.new
	extensions = Ext::Extensions.new

	fancy = Fancyline.new
	fancy = builtins.prompt(fancy, extensions)

	while input = fancy.readline(extensions.prompt()) # Ask the user for input
		next if input.nil? || input.empty?

		if input.includes?("<")
			if input.includes?(">")
				
			else
				puts "unbalanced subsitute"
			end
		end

		input = input.split(" ")

		#split input into base and arguments
		base = input.shift
		args = input

		handle(base, args, extensions, builtins)
	end
end

main()
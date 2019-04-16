require "fancyline"
require "./builtins.cr"
require "./ext.cr"

def run(base, args)
	#fork process and transorm into base and arguments
	process = Process.fork {
		begin
			Process.exec base, args
		rescue
			puts "command not found"
		end
	}
	#wait for process to end
	process.wait()
end	

def main()
	fancy = Fancyline.new

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
		elsif extensions.handle(base, args) != false
		elsif builtins.handle(base, args) != false
		else
			run base, args
		end
	end
end

main()
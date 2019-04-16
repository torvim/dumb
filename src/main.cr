require "fancyline"
require "./builtins.cr"
require "./ext.cr"

def main()
	fancy = Fancyline.new

	while input = fancy.readline(Dir.current + " > ") # Ask the user for input
		next if input.nil? || input.empty?
		input = input.split(" ")

		#split input into base and arguments
		base = input.shift
		args = input

		builtins = Ins::Builtins.new
		extensions = Ext::Extensions.new

		if builtins.handle(base, args) != false
		elsif extensions.handle(base, args) != false
		else
			#fork process and transorm into base and arguments
			process = Process.fork {
				Process.exec base, args
			}
			#wait for process to end
			process.wait()
		end
	end
end

main()
require "fancyline"
require "./builtins.cr"
require "./ext.cr"

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

		if builtins.handle(base, args) != false
		elsif extensions.handle(base, args) != false
		else
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
	end
end

main()
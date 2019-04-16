require "fancyline"


def main()

	fancy = Fancyline.new

	while input = fancy.readline("$ ") # Ask the user for input
		next if input.nil? || input.empty?
		input = input.split(" ")

		#split input into base and arguments
		base = input.shift
		args = input

		#fork process and transorm into base and arguments
		process = Process.fork {
			Process.exec base, args
		}

		#wait for process to end
		process.wait()
	end
end

main()
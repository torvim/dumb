require "fancyline"


def main()

	loop do
		fancy = Fancyline.new
		input = fancy.readline("> ")
		next if input.nil? || input.empty?
		input = input.split(" ")

		base = input.shift
		args = input

		process = Process.fork {

			Process.exec base, args
			
		}

		process.wait()
	end
end

main()
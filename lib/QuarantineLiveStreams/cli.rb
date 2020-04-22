require "pry"
class QuarantineLiveStreams::CLI

    def call
        puts "hello"
        binding.pry
    end
end
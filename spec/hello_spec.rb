require 'rspec'
require './lib/hello'


RSpec.describe Hello do
  describe '::hello' do
    it 'returns the greeting hello' do
      expect(Hello.say_hello).to eq("hello!")
    end
  end
end
class MyClass
  def method_1(param)
    puts "Inside block with param: #{param}"
  end
end

def my_method()
  puts 'Inside my_method()'

  MyClass.new.method_1('custom_param')

  #call block
  if block_given?
    yield()
  end

end

def method_2(param1, param2)

end

puts '1>'
puts my_method # output: Inside my_method()


puts
puts '2>'
puts my_method() { |param|
  puts "Inside block with param: #{param}"
}



#output:
#Inside my_method()
#Inside block
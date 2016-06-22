def my_method()
  puts 'Inside my_method()'

  #call block
  if block_given?
    puts 'There is a block'
    yield('custom_param')
  end

end


puts '1>'
puts my_method
# output: Inside my_method()


puts
puts '2>'
puts(my_method do |param|
  puts "Inside block: #{param}"
end)
#output:
#Inside my_method()
#There is a block
#Inside block: custom_param


puts
puts '3>'
puts my_method do |param|
  puts "Inside block: #{param}"
end
#output:
#Inside my_method()


puts
puts '4>'
puts my_method { |param|
  puts "Inside block: #{param}"
}
#output:
#Inside my_method()
#There is a block
#Inside block: custom_param

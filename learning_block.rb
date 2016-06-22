def my_method()
  puts 'Inside my_method()'

  #call block
  if block_given?
    puts 'There is a block'
    yield('custom_param')
  end

  puts '....done'

end


puts '1>'
puts my_method
# output:
#Inside my_method()
#....done



puts
puts '2>'
puts(my_method do |param|
  puts "Inside block: #{param}"
end)
#output:
#Inside my_method()
#There is a block
#Inside block: custom_param
#....done



puts
puts '3>'
puts my_method do |param|
  puts "Inside block: #{param}"
end # this `do..end` block belongs to `puts` instead of `my_method`, the same as `puts(my_method) do |param| ... end`
#output:
#Inside my_method()
#....done



puts
puts '4>'
puts my_method { |param|
  puts "Inside block: #{param}"
} # this `{}` block belongs to `my_method`, the same as `puts(my_method {|param| ... })`
#output:
#Inside my_method()
#There is a block
#Inside block: custom_param
#....done



puts
puts '5>'
puts my_method { |param|
  puts "Inside block: #{param}"
  return 'Return in block' #this will raise error since block cannot return
}
#output:
#Inside my_method()
#There is a block
#Inside block: custom_param
#unexpected return (LocalJumpError)
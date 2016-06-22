require 'yaml'

#############################################
## GET data from file_path have been provided
def list_post(file_path)
  YAML::load(File.read(file_path));
end

def check_request(format_type, data)
  if format_type == "format_1"
    only_title(data)
  elsif format_type == "format_2"
    title_and_author(data)
  else
    html_result(data)
  end

end

def get_formatter(format_id)
  case format_id
    when 'format_1'
      TitleOnlyFormatter.new
    when 'format_2'
      TitleAndAuthorFormatter.new
    when 'format_3'
      HtmlFormatter.new
    else
      raise "Not support format: #{format_id}"
  end
end

###################################
#Handle
def run(format_id, file_name)
  data = list_post(file_name)

  if block_given?
    yield(data)
  else
    formatter = get_formatter(format_id)
    formatter.format(data)
  end
end



###################################
# all style format
###################################
class TitleOnlyFormatter
  def format(data)
    titles = data.map do |post|
      post['title']
    end
    titles.join("\n")
  end
end

class TitleAndAuthorFormatter
  def format(data)
    titles = data.map do |post|
      "#{post['title']} - #{post['author']}"
    end
    titles.join("\n")
  end
end

class HtmlFormatter
  def format(data)
    titles = data.map do |post|
      "<li>#{post['title']}</li>"
    end
    "<ul>\n#{titles.join("\n")}\n</ul>"
  end
end


###################################


####################################
# Test
def test_output_with_title_only
  file_name = "data.yml"
  output = run("format_1", file_name)
  expected_output = "post 1
post 2
post 3
post 4"

  puts "Real output:"
  p output
  puts "Expected output:"
  p expected_output
  puts "Real output == expected output: #{output == expected_output}"

end


def test_output_with_title_and_author
  file_name = "data_2.yml"
  output = run('format_2', file_name )

  expected_output = "post 1 - author_a@domain.com
post 2 - author_a@domain.com
post 3 - author_b@domain.com"
# post 4 - author_b@domain.com"

  puts "Real output:"
  p output
  puts "Expected output:"
  p expected_output
  puts "Real output == expected output: #{output == expected_output}"
end


def test_output_with_title_only_in_html_format
  file_name = "data_3.yml"
  output = run("format_3", file_name)
  expected_output = "<ul>
<li>post 1</li>
<li>post 3</li>
</ul>"

  puts "Real output:"
  p output
  puts "Expected output:"
  p expected_output
  puts "Real output == expected output: #{output == expected_output}"

end

def test_anonymous_format
  file_name = "data_3.yml"
  output = run(nil, file_name) { |data|
    titles = data.map {|p| "- #{p['title']}" }
    titles.join("\n")
  }

  expected_output = "- post 1
- post 3"

  puts "Real output:"
  p output
  puts "Expected output:"
  p expected_output
  puts "Real output == expected output: #{output == expected_output}"
end

puts '-'*50
test_output_with_title_only
puts
puts '-'*50
test_output_with_title_and_author
puts
puts '-'*50
test_output_with_title_only_in_html_format
puts
puts '-'*50
test_anonymous_format
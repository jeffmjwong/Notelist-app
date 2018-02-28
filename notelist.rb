require 'terminal-table'

class Notelist
  attr_reader :list
  def initialize
    @list = []
  end

  def add_note(note)
    @list.push(note)
  end

  def delete_note(index_number_in_list)
    @list.delete_at(index_number_in_list - 1)
  end

  def read_note(index_number_in_list)
    file = @list[index_number_in_list - 1][:file_path]
    File.open(file).each do |line|
      puts line
    end
  end

  def display_title(title)
    table = Terminal::Table.new do |t|
      t.add_row [title]
    end
    table.style = {
      width: 200,
      padding_left: 85,
      border_x: "*",
      border_i: "*"
    }
    puts table
  end

  def display_list
    table = Terminal::Table.new do |t|
      t.title = "Awesome Note List"
      t.headings = ["Note Title", "Date"]
      if @list.empty?
        t.add_row ["", ""]
      else
        @list.each do |item|
          t.add_row [item[:title], item[:date]]
        end
      end
    end
    table.style = {
      width: 200
    }
    puts table
  end
end

system "clear"

notelist = Notelist.new

# running the following app
notelist.display_title("Welcome to JeffChen Notelist!")
3.times { puts "" }
if File.exist?("list.txt")
  notelist.list = Marshal.load File.read("list.txt")
else
  puts "wrong"
end
notelist.display_list
3.times { puts "" }
puts "Your notelist is empty!" if notelist.list.empty?
loop do
  3.times { puts "" }
  print "Please select the following action: 'a' to add note, 'l' to show list, 'q' to quit, 'r' to read note "
  user_input = gets.chomp.downcase
  case

  when user_input == "a"
    3.times { puts "" }
    puts "Please enter the title of your note: "
    title = gets.chomp
    3.times { puts "" }
    puts "Please enter the date: "
    date = gets.chomp
    3.times { puts "" }
    puts "Please enter the path of the file: "
    file_path = gets.chomp
    note = {title: title, date: date, file_path: file_path}
    puts note1
    notelist.add_note(note1)
    puts notelist.list
    system "clear"
    notelist.display_list

  when user_input == "d"
    print "Please select the number index of note that you want to delete: "
    user_input2 = gets.chomp.to_i
    notelist.delete_note(user_input2)
    system "clear"
    notelist.display_list

  when user_input == "q"
    puts "Thanks for using JeffChen Notelist. Have a nice day!"
    break

  when user_input == "l"
    system "clear"
    notelist.display_list

  when user_input == "r"
    print "Please select the number index of note that you want to read: "
    user_input2 = gets.chomp.to_i
    system "clear"
    notelist.read_note(user_input2)
  end

end




# ruby = Notelist.new("Ruby Notes")
# note1 = {
#   title: "How to get input from user",
#   file_name: "input.rb"
# }
# note2 = {
#   title: "asdafsdf",
#   file_name: "ctest.rb"
# }
# ruby.add_note(note1)
# ruby.add_note(note2)
# puts ruby.name
# puts ruby.list
# ruby.read_note(1)
# ruby.delete_note(1)
# puts ruby.list





# File.open("input.rb").each do |line|
#   puts line
# end

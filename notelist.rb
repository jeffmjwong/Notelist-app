require 'terminal-table'

class Notelist
  attr_accessor :list
  def initialize
    @list = []
  end

  def add_note(note)
    list.push(note)
  end

  def delete_note(index_number_in_list)
    list.delete_at(index_number_in_list - 1)
  end

  def read_note(index_number_in_list)
    puts "Note Start".center(200, "*")
    put_space
    file = list[index_number_in_list - 1][:file_path]
    File.open(file).each do |line|
      puts line
    end
    put_space
    puts "Note End".center(200, "*")
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
    table = Terminal::Table.new
    table.style = {
      alignment: :center,
      width: 200
    }
    # table do |t|
    #   t.title = "Awesome Note List"
    #   t.headings = [{value: "Number Index", width: 50}, "Note Title", "Date Added"]
    #   if list.empty?
    #     t.add_row ["", "", ""]
    #   else
    #     list.each_with_index do |item, index|
    #       t.add_row [
    #         {value: "#{index + 1}", alignment: :center},
    #         {value: item[:title], alignment: :center},
    #         {value: item[:date], alignment: :center}
    #       ]
    #     end
    #   end
    # end
    puts table
  end

  def put_space
    2.times { puts "" }
  end
end

# running the following app

system "clear"

notelist = Notelist.new

notelist.display_title("Welcome to JeffChen Notelist!")
notelist.put_space
if File.exist?("list.txt")
  notelist.list = Marshal.load File.read("list.txt")
end
notelist.display_list
if notelist.list.empty?
  notelist.put_space
  puts "Your notelist is empty!"
end

loop do
  notelist.put_space
  puts "Please select the following action:\n'l' to show list\n'a' to add note\n'd' to delete note\n'r' to read note\n'q' to quit"
  user_input = gets.chomp.downcase
  case

  when user_input == "l"
    system "clear"
    notelist.put_space
    notelist.display_list

  when user_input == "a"
    notelist.put_space
    puts "Please enter the title of your note, or type 'b' to go back: "
    title = gets.chomp
    if title.downcase == "b"
      next
    end
    date = Time.now.strftime("%F %T")
    notelist.put_space
    puts "Please enter the full or relative path of the note file, or type 'b' to go back: "
    file_path = gets.chomp
    if file_path.downcase == "b"
      next
    elsif !File.file?(file_path)
      notelist.put_space
      puts "The note file that you supplied does not exist! Please try again."
      next
    end
    note = {title: title, date: date, file_path: file_path}
    notelist.add_note(note)
    system "clear"
    notelist.put_space
    notelist.display_list

  when user_input == "d"
    if notelist.list.empty?
      notelist.put_space
      puts "The note list is empty. There is nothing to delete."
      next
    end
    system "clear"
    notelist.put_space
    notelist.display_list
    notelist.put_space
    print "Please select the number index of note that you want to delete, or type 'b' to go back: "
    number_index = gets.chomp
    if number_index.downcase == "b"
      next
    end
    begin
      number_index = Integer(number_index)
      unless number_index < 1 || number_index > notelist.list.length
        notelist.delete_note(number_index)
      else
        notelist.put_space
        puts "Invalid input. Please try again."
        next
      end
    rescue
      notelist.put_space
      puts "Invalid input. Please try again."
      next
    end
    system "clear"
    notelist.put_space
    notelist.display_list

  when user_input == "r"
    if notelist.list.empty?
      notelist.put_space
      puts "Please add at least one note before reading note."
      next
    end
    system "clear"
    notelist.put_space
    notelist.display_list
    notelist.put_space
    print "Please select the number index of the note that you want to read, or type 'b' to go back: "
    number_index = gets.chomp
    if number_index.downcase == "b"
      next
    end
    begin
      number_index = Integer(number_index)
      unless number_index < 1 || number_index > notelist.list.length
        system "clear"
        notelist.put_space
        notelist.read_note(number_index)
      else
        notelist.put_space
        puts "Invalid input. Please try again."
        next
      end
    rescue
      notelist.put_space
      puts "Invalid input. Please try again."
      next
    end

  when user_input == "q"
    system "clear"
    notelist.put_space
    puts "Thank you for using JeffChen Notelist. Have a nice day!"
    notelist.put_space
    break

  else
    notelist.put_space
    puts "That is not a valid option. Please try again."
    next
  end

end

File.open("list.txt", "w") {|f| f.write(Marshal.dump(notelist.list))}

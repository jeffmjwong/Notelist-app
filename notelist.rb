require 'terminal-table'
require 'colorize'

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
    file = list[index_number_in_list - 1][:file_path]
    if File.file?(file)
      puts "Note Start".center(170, "*")
      put_space
      File.open(file).each do |line|
        puts line
      end
      put_space
      puts "Note End".center(170, "*")
    else
      put_space
      puts "The note file that you are trying to read does not exist anymore. This note will now be deleted from the note list."
      delete_note(index_number_in_list)
      put_space
      display_list
    end
  end

  def display_title(title)
    table = Terminal::Table.new do |t|
      t.add_row [title]
    end
    table.style = {
      width: 170,
      alignment: :center,
      border_x: "*".colorize(:yellow),
      border_i: "*".colorize(:yellow)
    }
    puts table
  end

  def display_list
    table = Terminal::Table.new do |t|
      t.title = "Awesome Note List".colorize(:red)
      t.headings = ["Number Index", "Note Title", "Date Added"]
      if list.empty?
        t.add_row ["", "", ""]
      else
        list.each_with_index do |item, index|
          t.add_row ["#{index + 1}".colorize(:blue), item[:title].colorize(:blue), item[:date].colorize(:blue)]
        end
      end
    end
    table.style = {
      alignment: :center,
      width: 170,
      border_x: "=",
      border_i: "x"
    }
    puts table
  end

  def put_space
    2.times { puts "" }
  end
end

# running the following app

system "clear"

notelist = Notelist.new

notelist.display_title("Welcome to JeffChen Notelist!".colorize(color: :green))
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

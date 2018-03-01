require 'terminal-table'
require 'colorize'
require 'tty-font'
require_relative 'notelist_class.rb'

system "clear"
notelist = Notelist.new
font = TTY::Font.new(:doom)

notelist.display_title(font.write("Welcome   To   Note   List!").colorize(color: :green))

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
    notelist.display_list

  when user_input == "a"
    notelist.put_space
    puts "Please enter the title of your note, or type 'b' to go back: "
    title = gets.chomp
    if title.downcase == "b"
      next
    end
    date = Time.now.strftime("%F %T")
    puts ""
    puts "Please enter the full or relative path of the note file, or type 'b' to go back: "
    file_path = gets.chomp
    if file_path.downcase == "b"
      next
    elsif !File.file?(file_path)
      notelist.put_space
      puts "The note file that you supplied does not exist! Please try again."
      next
    end
    system "clear"
    notelist.add_note(title, date, file_path)

  when user_input == "d"
    if notelist.list.empty?
      notelist.put_space
      puts "The note list is empty. There is nothing to delete."
      next
    end
    system "clear"
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
        system "clear"
        notelist.delete_note(number_index)
      else
        notelist.invalid_input_message
        next
      end
    rescue
      notelist.invalid_input_message
      next
    end

  when user_input == "r"
    if notelist.list.empty?
      notelist.put_space
      puts "Please add at least one note before reading note."
      next
    end
    system "clear"
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
        notelist.read_note(number_index)
      else
        notelist.invalid_input_message
        next
      end
    rescue
      notelist.invalid_input_message
      next
    end

  when user_input == "q"
    system "clear"
    notelist.put_space
    puts "Thank you for using JeffChen Notelist. Have a nice day!"
    notelist.put_space
    break

  else
    notelist.invalid_input_message
    next
  end

end

File.open("list.txt", "w") {|f| f.write(Marshal.dump(notelist.list))}

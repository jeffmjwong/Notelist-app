class Notelist
  attr_accessor :list
  def initialize
    @list = []
  end

  def add_note(title, date, file_path)
    note = {title: title, date: date, file_path: file_path}
    list.push(note)
    display_list
  end

  def delete_note(index_number_in_list)
    list.delete_at(index_number_in_list - 1)
    display_list
  end

  def read_note(index_number_in_list)
    put_space
    file = list[index_number_in_list - 1][:file_path]
    if File.file?(file)
      puts "Note Start".center(155, "*")
      put_space
      File.open(file).each do |line|
        puts line
      end
      put_space
      puts "Note End".center(155, "*")
    else
      put_space
      puts "The note file that you are trying to read does not exist anymore. This note will now be deleted from the note list."
      delete_note(index_number_in_list)
    end
  end

  def display_title(title)
    table = Terminal::Table.new do |t|
      t.add_row [title]
    end
    table.style = {
      width: 155,
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
      width: 155,
      border_x: "=",
      border_i: "x"
    }
    put_space
    puts table
  end

  def invalid_input_message
    put_space
    puts "Invalid input. Please try again."
  end

  def put_space
    2.times { puts "" }
  end
end

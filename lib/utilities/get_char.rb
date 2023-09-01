module GetChar
  def get_char
    input = STDIN.getch
    control_c_code = "\u0003"
    exit(1) if input == control_c_code
    input
  end
end

class String
  def capitalize_phrase
    #self.sub(/^(\w)/) {|s| s.capitalize}
    self.split.collect(&:capitalize).join(" ")
  end
end
class String
  def camelize(first_letter = :upper)
    self.downcase.gsub(/_\w/) { |x| x[1..1].upcase }.gsub(/^\w/) { |x| first_letter.eql?(:upper) ? x.upcase : x }
  end
end

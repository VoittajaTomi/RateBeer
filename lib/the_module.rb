module TheModule

  def avg(x)
 
    count = x.count
    return 0 if count==0
    sum = x.inject(0.0) { |result, element| result + element.score }
    return sum / count

  end



end

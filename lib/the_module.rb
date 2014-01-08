module TheModule

  def avg(x)

    sum = x.inject(0.0) { |result, element| result + element.score }
    return sum / x.count

  end



end

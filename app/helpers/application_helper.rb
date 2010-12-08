module ApplicationHelper
  def make_class(c)
    [c.first.to_s.gsub(/^(\S+)_/, ''), to_words(c.last)].join(' ')
  end
  
  def to_words(score)
    case
    when score >= 0.9 then "strong"
    when score >= 0.8 then "moderate"
    when score >= 0.5 then "mild"
    else ''
    end
  end
end

module ApplicationHelper
  def make_class(c)
    [c.first.to_s.gsub(/^(\S+)_/, ''), to_words(c.last)].join(' ')
  end
  
  def to_words(score)
    case
    when score == 0.5 then ''
    when score >= 0.9 then "strong"
    when score >= 0.8 then "moderate"
    when score >= 0.5 then "mild"
    else ''
    end
  end
  
  def to_name(crm_pair)
    crm_pair.first.to_s.gsub(/^(\S+)_/, '')
  end
  
  def to_score(crm_pair)
    crm_pair.last * (to_name(crm_pair) == 'hate' ? -1 : 1)
  end
end

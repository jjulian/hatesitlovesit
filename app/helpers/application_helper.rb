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
  
  def pretty_score(crm_pair)
    "#{to_name(crm_pair)}! #{to_score(crm_pair).abs}" unless to_score(crm_pair).abs == 0.5 || to_score(crm_pair) == 0.0
  end

  def pretty_time(time)
    time = DateTime.parse(time) if time.is_a?(String)
    if time > 1.day.ago
      "#{time_ago_in_words(time)} ago"
    else
      time.in_time_zone.to_s
    end
  end

end

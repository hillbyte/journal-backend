# app/services/mood_analyzer.rb
class MoodAnalyzer
  def initialize
    @analyzer = Sentimental.new
    @analyzer.load_defaults
  end

  def analyze(text)
    sentiment = @analyzer.sentiment(text)
    score = @analyzer.score(text)

    case sentiment
    when :positive
      return score > 0.5 ? "very_happy" : "happy"
    when :negative
      return score < -0.5 ? "very_sad" : "sad"
    else
      return "neutral"
    end
  end
end

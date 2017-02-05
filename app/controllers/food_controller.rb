  class FoodController < ApplicationController

  def index
    food_count = Food.count
    food_random = rand(1..food_count)
    @food = Food.find(food_random).name.gsub(/\w+/, &:capitalize)

    @random_question_array = ["What do you feel like eating today?", "What do you crave now?", "I could so go for ... ", "Today is the day I eat", "You know you want...", "Anyone would have suggested...", "If I had to say...", "You must crave...", "Let me guess...", "May I suggest...", "What does your stomach want?", "What does your tummy want?", "You tummy is all for", "Your tummy says HELLO to", "Your face tells me that you want...", "Open your arms and embrace", "Don't waver, you want", "Thank me later, get...", "Live to eat, enjoy...", "Your money wants...", "Your tummy wants...", "You subconsciously smell...", "Don't doubt, don't resist, eat", "Close your eyes and imagine", "Hands down, you definitely want", "You secretly want", "A foodie would recommend"]
    @random_question = @random_question_array.shuffle.first
    @adjectives_array = ["a super delicious", "a mouth-watering", "an irresistable", "a heavenly", "a divine taste of", "an incredible", "a superb", "an appetizing", "a satisfying", "a beastly", "a super tasty", "an uberdelicious", "a quality", "a perfecto", "a five-star", "a dream-fulfilling", "a supreme", "a fantastic", "a wonderful", "an amazing"]
    @adjectives = @adjectives_array.shuffle.first

    sleep 1

    respond_to do |format|
      format.html { render('index') }
    end

    # offset = rand(Food.count)
    # @rand_record = Food.offset(offset).first

    # @food = Food.random.without(params[:last_ids]).limit(1)
    # binding.pry

  end

  def generate
    food_count = Food.count
    food_random = rand(1..food_count)
    @food = Food.find(food_random).name

    @random_question_array = ["What do you feel like eating today?", "What do you crave now?", "I could so go for ... ", "Today is the day I eat", "You know you want...", "Anyone would have suggested...", "If I had to say...", "You must crave...", "Let me guess...", "May I suggest...", "What does your stomach want?", "What does your tummy want?", "You tummy is all for", "Your tummy says HELLO to", "Your face tells me that you want...", "Open your arms and embrace", "Don't waver, you want", "Thank me later, get...", "Live to eat, enjoy...", "Your money wants...", "Your tummy wants...", "You subconsciously smell...", "Don't doubt, don't resist, eat", "Close your eyes and imagine", "Hands down, you definitely want", "You secretly want", "A foodie would recommend"]
    @random_question = @random_question_array.shuffle.first
    @adjectives_array = ["a super delicious", "a mouth-watering", "an irresistable", "a heavenly", "a divine taste of", "an incredible", "a superb", "an appetizing", "a satisfying", "a beastly", "a super tasty", "an uberdelicious", "a quality", "a perfecto", "a five-star", "a dream-fulfilling", "a supreme", "a fantastic", "a wonderful", "an amazing"]
    @adjectives = @adjectives_array.shuffle.first


    sleep 1

    respond_to do |format|
      format.js
    end
  end

  def updates
    @time = Time.now.strftime("%d/%m/%Y %H:%M")
  end



end

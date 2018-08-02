class SiteController < ApplicationController

  MONEY_BAG = "💰"
  DIAMOND   = "💎"

  def about
    render "about.#{I18n.locale}"
  end

  def faq
    render "faq.#{I18n.locale}"
  end

  def donate
    @donations = [
      { name: "Matthew", amount: print_money(66) },
      { name: "Noah",    amount: print_money(53) },
      { name: "Renee",   amount: print_money(5) },
      { name: "Kevin",   amount: print_money(8) }
    ]

    render "donate.#{I18n.locale}"
  end

  def apps
  end

  private

  RATIO = 50

  def print_money amount
    diamonds = amount / RATIO
    money_bags = amount % RATIO

    "#{DIAMOND*diamonds}#{MONEY_BAG*money_bags}"
  end

end

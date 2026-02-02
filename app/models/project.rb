class Project < ApplicationRecord
  validates :title, presence: true
  has_one_attached :banner

  # Pour transformer nos chaînes de caractères en listes utilisables dans la vue
  def stack_list
    stack.to_s.split(",").map(&:strip)
  end

  def challenges_list
    challenges.to_s.split(";").map(&:strip)
  end

  def solutions_list
    solutions.to_s.split(";").map(&:strip)
  end
end

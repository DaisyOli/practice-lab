class Experiment < ApplicationRecord
  enum :status, {
    idea: "idea",
    prototype: "prototype",
    testing: "testing",
    validated: "validated",
    archived: "archived"
  }, validate: true

  validates :title, :slug, :purpose, presence: true
  validates :slug, uniqueness: true
end

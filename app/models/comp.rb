class Comp < ActiveRecord::Base

  def landscape?
    !portrait?
  end
end

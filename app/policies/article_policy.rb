class ArticlePolicy < ApplicationPolicy
  
  def index?
    true
  end
  
  def show?
    true
  end
    
end

class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    
    def index?
      true
    end
    
    def show?
      true
    end
    
  end
end

class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
    
    def index?
      true
    end
    
    def show?
      true
    end
    
  end
end

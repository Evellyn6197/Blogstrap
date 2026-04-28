class ArticlePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user.id == record.user.id
  end

  def destroy?
    user.id == record.user.id
  end
  
end

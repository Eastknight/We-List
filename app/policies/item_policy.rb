class ItemPolicy < ApplicationPolicy
  def show?
    scope.where(:id => record.id).exists? && user.present? && record.list.user == user
  end

  def update?
    user.present? && record.list.user == user
  end

  def destroy?
    update?
  end
end
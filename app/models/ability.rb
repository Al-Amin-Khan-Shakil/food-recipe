class Ability
  include CanCan::Ability

  def initialize(current_user)
    @user = current_user || User.new
    can :destroy, Recipe, user_id: @user.id
  end
end

module ApplicationHelper
    def user_email(user_id)
        return User.find(user_id).email
    end
end

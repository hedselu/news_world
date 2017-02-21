class User
  class Password
    include ActiveModel::Validations

    attr_accessor :original_password, :new_password

    validate :authenticate_original_password
    validate :new_password_difference
    validates :new_password, confirmation: true, length: { minimum: 8 }, format: { with: /.*[a-z][0-9]{2,}/ },
                             presence: true

    def initialize(user)
      @user = user
    end

    def change(passwords)
      self.original_password = passwords[:original_password]
      self.new_password = passwords[:new_password]
      self.new_password_confirmation = passwords[:new_password_confirmation]
      if valid?
        @user.password = new_password
        @user.save
        true
      else
        false
      end
    end

    private

    def new_password_difference
      errors.add :new_password, 'new password matches original' if original_password == new_password
    end

    def authenticate_original_password
      errors.add :original_password, 'incorrect' unless @user.authenticate(original_password)
    end
  end
end

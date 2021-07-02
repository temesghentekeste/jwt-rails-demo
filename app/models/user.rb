class User < ApplicationRecord
    has_many :balloons
    has_secure_password

end

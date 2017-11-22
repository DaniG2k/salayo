module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', "User #{current_user.email} - id: #{current_user.id}"
    end

    private

      def find_verified_user
        verified_user = User.find_by(id: cookies.signed['user.id'])
        if verified_user && cookies.signed['user.expires_at'] > Time.zone.now
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end

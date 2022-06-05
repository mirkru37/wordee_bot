module Telegram
  module V1
    class BaseController < Telegram::Bot::UpdatesController
      def action_missing(*)
        return unless action_type == :command

        respond_with :message,
                     text: "missing command #{action_options[:command]}"
      end

      class << self
        def match_command?(**)
          false
        end
      end
    end
  end
end

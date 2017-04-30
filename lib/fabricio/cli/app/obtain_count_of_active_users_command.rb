require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_count_of_active_users [APPLICATION_ID] [USERNAME] [PASSWORD]', 'Obtains the count of active users at the current moment.'
    def obtain_count_of_active_users(application_id, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      count_of_active_users = client.app.active_now(application_id)

      unless count_of_active_users
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(count_of_active_users)
    end

    private

    def print_table(count_of_active_users)
      table = Terminal::Table.new do |t|
        rows = {}
        rows['Count of active users'] = count_of_active_users

        t.rows = rows
      end

      puts table
    end

  end
end
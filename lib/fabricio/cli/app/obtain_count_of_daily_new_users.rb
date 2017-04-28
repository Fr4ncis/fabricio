require 'thor'
require 'terminal-table'
require 'fabricio/client/client'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_count_of_daily_new_users [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [USERNAME] [PASSWORD]', 'Obtains the count of daily new users.'
    def obtain_count_of_daily_new_users(application_id, start_timestamp, end_timestamp, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      points = client.app.daily_new(application_id, start_timestamp, end_timestamp)

      unless points
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(points)
    end

    private

    def print_table(points)
      table = Terminal::Table.new do |t|
        rows = {}

        points.each do |point|
          rows[point.date.strftime('%d.%m.%Y')] = point.value.to_i
        end

        t.headings = ['Date', 'Count of new users']
        t.rows = rows
        t.align_column(1, :center)
      end

      puts table
    end

  end
end
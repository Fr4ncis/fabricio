require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_count_of_daily_active_users [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [BUILD_NUMBER] [USERNAME] [PASSWORD]', 'Obtains the count of daily active users.'
    def obtain_count_of_daily_active_users(application_id, start_timestamp, end_timestamp, build_number, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      points = client.app.daily_active(application_id, start_timestamp, end_timestamp, build_number)

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

        t.headings = ['Date', 'Count of active users']
        t.rows = rows
        t.align_column(1, :center)
      end

      puts table
    end

  end
end
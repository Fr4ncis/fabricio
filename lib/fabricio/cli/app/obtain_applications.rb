require 'thor'
require 'terminal-table'
require 'fabricio/client/client'
require 'fabricio/models/organization'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_applications [USERNAME] [PASSWORD]', 'Obtains the list of all apps.'
    def obtain_applications(username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      print_applications(client.app.all)
    end

    private

    def print_applications(applications)
      ios_applications = applications.select { |application|
        application.platform == 'ios'
      }

      android_applications = applications.select { |application|
        application.platform == 'android'
      }

      other_applications = applications.select { |application|
        application.platform != 'ios' && application.platform != 'android'
      }

      print_table(ios_applications, 'The list of iOS applications') unless ios_applications.empty?
      print_table(android_applications, 'The list of Android applications') unless android_applications.empty?
      print_table(other_applications, 'The list of other platform applications') unless other_applications.empty?
    end

    def print_table(applications, title)
      table = Terminal::Table.new do |t|
        rows = {}

        applications.each_with_index do |application, index|
          rows[index + 1] = "id: #{application.id}\nname: #{application.name}\nbundle_id: #{application.bundle_id}\ncreated_at: #{application.created_at}\nplatform: #{application.platform}\nicon_url: #{application.icon_url}"
        end

        t.rows = rows
        t.title = title
        t.style = {:all_separators => true}
      end

      puts table
    end
  end
end
require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_organization_info [USERNAME] [PASSWORD]', 'Obtains information about your organization.'
    def obtain_organization_info(username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      print_table(client.organization.get)
    end

    private

    def print_table(organization)
      table = Terminal::Table.new do |t|
        rows = {}
        rows['ID'] = organization.id
        rows['Alias'] = organization.alias
        rows['Name'] = organization.name

        ios_apps_count = organization.apps_counts['ios']
        rows['Count of iOS applications'] = ios_apps_count if ios_apps_count > 0

        android_apps_count  = organization.apps_counts['android']
        rows['Count of Android applications'] = android_apps_count if android_apps_count > 0

        t.rows = rows
      end

      puts table
    end

  end
end
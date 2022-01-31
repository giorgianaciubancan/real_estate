class Scripts::Calendars

    def self.init_google_calendars
        service = Calendar.init_service
        accounts = Account.all

        accounts.each do |account|
            # Calendar.create_calendar_for_account(service, account)
            Calendar.populate_calendar(service, account)
        end
        
    end

    # Used for testing
    # Scripts::Calendars.view_events
    def self.view_events
        service = Calendar.init_service
        accounts = Account.all
        accounts.each do |account|
            response = service.list_events(account.calendar_id,
                max_results: 10,
                single_events: true,
                order_by: 'startTime',
                time_min: Time.now.iso8601)
            puts 'Upcoming events for:' + account.calendar_id
            puts 'No upcoming events found' if response.items.empty?
            response.items.each do |event|
            start = event.start.date || event.start.date_time
            puts "- #{event.summary} (#{start})"
            end
        end
    end

    def self.test
        service = Calendar.init_service
        calendar_id = "4mrk1u7oe0nq5gl6c4atui055g@group.calendar.google.com";
        event = Google::Apis::CalendarV3::Event.new(
            summary: 'Google I/O 2015',
            description: 'A chance to hear more about Google\'s developer products.',
            start: Google::Apis::CalendarV3::EventDateTime.new(
              date_time: '2015-05-28T09:00:00-07:00',
              time_zone: 'America/Los_Angeles'
            ),
            end: Google::Apis::CalendarV3::EventDateTime.new(
              date_time: '2015-05-28T17:00:00-07:00',
              time_zone: 'America/Los_Angeles'
            )
        )
        service.insert_event(calendar_id, event)

    end

end
class Calendar 

    # Function that inits a google calendar service
    def self.init_service
        scope = 'https://www.googleapis.com/auth/calendar'
        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
            json_key_io: File.open("credentials.json"),
            scope: scope)
        authorizer.fetch_access_token!
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = authorizer
        service
    end

    # Function that creates a calendar for a given account
    def self.create_calendar_for_account(service, account)
        calendar = Google::Apis::CalendarV3::Calendar.new(
            summary: "#{account.first_name}'s Calendar",
            time_zone: 'Europe/Bucharest'
        )
        result = service.insert_calendar(calendar)
        account.calendar_id = result.id
        account.save

        rule = Google::Apis::CalendarV3::AclRule.new(
            scope: {
              type: 'domain',
              value: 'takeofflabs.com',
            },
            role: 'reader'
          )
          control_rule = service.insert_acl(result.id, rule)
    end

    # Function that adds all the existing meetings to the calendar
    def self.populate_calendar(service, account)
        meetings = account.meetings
        meetings.each do |meeting|
            puts "Adding meeting #{meeting.id}"
            event_id = "meeting#{meeting.id}"
            start_moment = meeting.start_time.strftime("%FT%H:%M:%S-00:00")
            variable = meeting.end_time + 1.day
            end_moment = variable.strftime("%FT%H:%M:%S-00:00")
            puts "Start time: #{start_moment}"
            puts "End time: #{end_moment}"
           
            event = Google::Apis::CalendarV3::Event.new(
                id: event_id,
                summary: "#{meeting.name}",
                start: Google::Apis::CalendarV3::EventDateTime.new(
                  date_time: start_moment,
                  time_zone: 'Europe/Bucharest'
                ),
                end: Google::Apis::CalendarV3::EventDateTime.new(
                  date_time: end_moment,
                  time_zone: 'Europe/Bucharest'
                )
            )

            # event = Calendar.create_event(meeting.name, start_moment, end_moment, event_id)
            puts "Event: #{event}"
            puts "Calendar ID: #{account.calendar_id}"
            service.insert_event(account.calendar_id, event)
            # meeting.add_meeting_to_calendar(account.calendar_id, service)
        end
    end

     # Function that creates and returns an event
     def self.create_event(meeting_name, start_date, end_date, event_id)
        event = Google::Apis::CalendarV3::Event.new(
          id: event_id,
          summary: "#{meeting_name}",
          start: Google::Apis::CalendarV3::EventDateTime.new(
            date: start_date,
            time_zone: 'Europe/Bucharest'
          ),
          end: Google::Apis::CalendarV3::EventDateTime.new(
            date: end_date,
            time_zone: 'Europe/Bucharest'
          )
        )
        return event 
      end


end
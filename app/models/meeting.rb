class Meeting < ApplicationRecord
    belongs_to :account

    # Function that adds a meeting to a given calendar
    def add_meeting_to_calendar(calendar_id, service)
        service = Calendar.init_service 
        event_id = "meeting#{id}"
        meeting_name = name
        event = Calendar.create_event(meeting_name, start_time, end_time + 1.day, event_id)
        # begin
        puts "Event is #{event}"
        service.insert_event(calendar_id, event)
        # rescue Google::Apis::ClientError => e
        # if e.status_code == 409
        #     # We are ignoring the case when adding a user back to a team
        #     puts 'Google API detected duplicate event id, ignoring'
        # else
        #     raise
        # end
        # end
    end
end
